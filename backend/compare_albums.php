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

// Loads one album's full tracklist, in its own track order, with
// credits — keyed by song_id so the two sides can be cross-referenced
// for the "also on the other album" highlight.
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
    $totalSeconds = 0;
    foreach ($rows as $row) {
        $creditStmt->execute(['recId1' => $row['recording_id'], 'recId2' => $row['recording_id']]);
        $row['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);
        $tracksBySong[$row['song_id']] = $row;
        $totalSeconds += (int) $row['duration_seconds'];
    }

    return [
        'album_id' => $albumId,
        'title' => $album['title'],
        'tracks' => $tracksBySong,
        'total_seconds' => $totalSeconds,
    ];
}

$albumA = $albumAId ? load_album_tracklist($pdo, $albumAId) : null;
$albumB = $albumBId ? load_album_tracklist($pdo, $albumBId) : null;

$sharedSongIds = [];
if ($albumA && $albumB) {
    $sharedSongIds = array_intersect_key($albumA['tracks'], $albumB['tracks']);
    $sharedSongIds = array_keys($sharedSongIds);
}

function format_total_time(int $seconds): string
{
    $hours = intdiv($seconds, 3600);
    $minutes = intdiv($seconds % 3600, 60);
    $secs = $seconds % 60;
    return $hours > 0
        ? sprintf('%d:%02d:%02d', $hours, $minutes, $secs)
        : sprintf('%d:%02d', $minutes, $secs);
}

// Renders one album's column: cover, title, stats, and its own
// tracklist table with shared-song rows highlighted.
function render_album_column(array $album, array $sharedSongIds, ?string $artwork): void
{
    ?>
    <section class="compare-column">
        <header class="compare-column-header">
            <?php if ($artwork): ?>
            <img class="compare-column-cover" src="<?= htmlspecialchars($artwork) ?>" width="72" height="72" alt="<?= htmlspecialchars($album['title']) ?> cover art">
            <?php endif; ?>
            <div>
                <h2><a href="tracklist.php?album_id=<?= (int) $album['album_id'] ?>"><?= htmlspecialchars($album['title']) ?></a></h2>
                <p class="muted">
                    <?= count($album['tracks']) ?> tracks · <?= format_total_time($album['total_seconds']) ?>
                </p>
            </div>
        </header>
        <div class="table-wrap">
            <table>
                <caption class="visually-hidden"><?= htmlspecialchars($album['title']) ?> tracklist</caption>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Title</th>
                    <th scope="col">Duration</th>
                    <th scope="col">Credits</th>
                </tr>
                <?php foreach ($album['tracks'] as $songId => $track): ?>
                <?php $isShared = in_array($songId, $sharedSongIds, true); ?>
                <tr class="<?= $isShared ? 'shared-row' : '' ?>">
                    <td><?= htmlspecialchars($track['track_number']) ?></td>
                    <td>
                        <?= htmlspecialchars($track['title']) ?>
                        <?php if ($isShared): ?>
                        <span class="tag muted">(shared)</span>
                        <?php endif; ?>
                    </td>
                    <td><?= $track['duration_seconds'] ? gmdate('i:s', $track['duration_seconds']) : '—' ?></td>
                    <td><?= htmlspecialchars(implode(', ', $track['credits'])) ?></td>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>
    </section>
    <?php
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
        <p class="muted">Tracks tagged <span class="tag muted">(shared)</span> appear on both albums.</p>
        <div class="compare-columns">
            <?php
            $artworkA = get_album_artwork($pdo, $albumA['album_id'], $albumA['title']);
            $artworkB = get_album_artwork($pdo, $albumB['album_id'], $albumB['title']);
            render_album_column($albumA, $sharedSongIds, $artworkA);
            render_album_column($albumB, $sharedSongIds, $artworkB);
            ?>
        </div>
        <?php else: ?>
        <p class="muted">Pick two albums to see their tracklists side by side, with shared songs highlighted.</p>
        <?php endif; ?>
    </main>
</body>
</html>
