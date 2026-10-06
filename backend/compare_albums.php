<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/artwork.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$albumsStmt = $pdo->query("SELECT album_id, title FROM albums ORDER BY release_date");
$allAlbums = $albumsStmt->fetchAll(PDO::FETCH_ASSOC);

$albumAId = isset($_GET['album_a']) ? (int) $_GET['album_a'] : 0;
$albumBId = isset($_GET['album_b']) ? (int) $_GET['album_b'] : 0;

// Loads one album's full tracklist, keyed by song_id, with credits.
function load_album_tracklist(PDO $pdo, int $albumId): ?array
{
    $albumStmt = $pdo->prepare("SELECT title FROM albums WHERE album_id = :id");
    $albumStmt->execute(['id' => $albumId]);
    $album = $albumStmt->fetch(PDO::FETCH_ASSOC);
    if (!$album) {
        return null;
    }

    $trackStmt = $pdo->prepare("
        SELECT s.song_id, s.title, at.track_number, r.version_type, r.duration_seconds, r.recording_id
        FROM album_tracks at
        JOIN recordings r ON r.recording_id = at.recording_id
        JOIN songs s ON s.song_id = r.song_id
        WHERE at.album_id = :albumId
        ORDER BY at.track_number
    ");
    $trackStmt->execute(['albumId' => $albumId]);
    $rows = $trackStmt->fetchAll(PDO::FETCH_ASSOC);

    $creditStmt = $pdo->prepare("
        (SELECT ar.name FROM recording_songwriters rs
            JOIN artists ar ON ar.artist_id = rs.artist_id
            WHERE rs.recording_id = :recId1)
        UNION
        (SELECT ar.name FROM recording_producers rp
            JOIN artists ar ON ar.artist_id = rp.artist_id
            WHERE rp.recording_id = :recId2)
        ORDER BY name
    ");

    $tracksBySong = [];
    foreach ($rows as $row) {
        $creditStmt->execute(['recId1' => $row['recording_id'], 'recId2' => $row['recording_id']]);
        $row['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);
        $tracksBySong[$row['song_id']] = $row;
    }

    return ['title' => $album['title'], 'tracks' => $tracksBySong];
}

$albumA = $albumAId ? load_album_tracklist($pdo, $albumAId) : null;
$albumB = $albumBId ? load_album_tracklist($pdo, $albumBId) : null;

$mergedRows = [];
if ($albumA && $albumB) {
    // Album A's songs first, in A's own track order, then any of B's
    // songs that A doesn't have, in B's track order.
    $songIds = array_keys($albumA['tracks']);
    foreach (array_keys($albumB['tracks']) as $songId) {
        if (!in_array($songId, $songIds, true)) {
            $songIds[] = $songId;
        }
    }

    foreach ($songIds as $songId) {
        $inA = $albumA['tracks'][$songId] ?? null;
        $inB = $albumB['tracks'][$songId] ?? null;
        $mergedRows[] = [
            'title' => ($inA ?? $inB)['title'],
            'a' => $inA,
            'b' => $inB,
        ];
    }
}

$pageTitle = ($albumA && $albumB)
    ? $albumA['title'] . ' vs ' . $albumB['title'] . ' — Taylor Swift Catalogue'
    : 'Compare Albums — Taylor Swift Catalogue';
$currentNav = 'compare_albums';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Compare Albums</h1>
        <form class="search-form" method="get" action="compare_albums.php">
            <label class="visually-hidden" for="album_a">First album</label>
            <select id="album_a" name="album_a">
                <option value="">Choose an album...</option>
                <?php foreach ($allAlbums as $a): ?>
                <option value="<?= (int) $a['album_id'] ?>" <?= $a['album_id'] == $albumAId ? 'selected' : '' ?>>
                    <?= htmlspecialchars($a['title']) ?>
                </option>
                <?php endforeach; ?>
            </select>
            <label class="visually-hidden" for="album_b">Second album</label>
            <select id="album_b" name="album_b">
                <option value="">Choose an album...</option>
                <?php foreach ($allAlbums as $a): ?>
                <option value="<?= (int) $a['album_id'] ?>" <?= $a['album_id'] == $albumBId ? 'selected' : '' ?>>
                    <?= htmlspecialchars($a['title']) ?>
                </option>
                <?php endforeach; ?>
            </select>
            <button type="submit">Compare</button>
        </form>

        <?php if ($albumAId && !$albumA): ?>
        <p>No album found for the first selection.</p>
        <?php elseif ($albumBId && !$albumB): ?>
        <p>No album found for the second selection.</p>
        <?php elseif ($albumA && $albumB): ?>
        <div class="table-wrap">
            <table>
                <caption class="visually-hidden"><?= htmlspecialchars($albumA['title']) ?> vs <?= htmlspecialchars($albumB['title']) ?></caption>
                <tr>
                    <th scope="col">Song</th>
                    <th scope="col"><?= htmlspecialchars($albumA['title']) ?> — #</th>
                    <th scope="col"><?= htmlspecialchars($albumA['title']) ?> — Duration</th>
                    <th scope="col"><?= htmlspecialchars($albumA['title']) ?> — Credits</th>
                    <th scope="col"><?= htmlspecialchars($albumB['title']) ?> — #</th>
                    <th scope="col"><?= htmlspecialchars($albumB['title']) ?> — Duration</th>
                    <th scope="col"><?= htmlspecialchars($albumB['title']) ?> — Credits</th>
                </tr>
                <?php foreach ($mergedRows as $row): ?>
                <tr>
                    <td>
                        <?= htmlspecialchars($row['title']) ?>
                        <?php if ($row['a'] && !$row['b']): ?>
                        <span class="tag muted">(only on <?= htmlspecialchars($albumA['title']) ?>)</span>
                        <?php elseif ($row['b'] && !$row['a']): ?>
                        <span class="tag muted">(only on <?= htmlspecialchars($albumB['title']) ?>)</span>
                        <?php endif; ?>
                    </td>
                    <td><?= $row['a'] ? htmlspecialchars($row['a']['track_number']) : '—' ?></td>
                    <td><?= $row['a'] && $row['a']['duration_seconds'] ? gmdate('i:s', $row['a']['duration_seconds']) : '—' ?></td>
                    <td><?= $row['a'] ? htmlspecialchars(implode(', ', $row['a']['credits'])) : '—' ?></td>
                    <td><?= $row['b'] ? htmlspecialchars($row['b']['track_number']) : '—' ?></td>
                    <td><?= $row['b'] && $row['b']['duration_seconds'] ? gmdate('i:s', $row['b']['duration_seconds']) : '—' ?></td>
                    <td><?= $row['b'] ? htmlspecialchars(implode(', ', $row['b']['credits'])) : '—' ?></td>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>
        <?php else: ?>
        <p class="muted">Pick two albums to see their tracklists side by side — shared songs line up by row, and anything unique to one album is labeled.</p>
        <?php endif; ?>
    </main>
</body>
</html>
