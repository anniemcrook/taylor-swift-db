<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/auth.php';
require __DIR__ . '/helpers.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$query = isset($_GET['q']) ? trim($_GET['q']) : '';
$results = [];

if ($query !== '') {
    $like = '%' . $query . '%';

    // Match by song title, or by the name of anyone credited as a
    // songwriter or producer on any recording of that song.
    $songStmt = $pdo->prepare("
        SELECT DISTINCT s.song_id, s.title
        FROM songs s
        LEFT JOIN recordings r ON r.song_id = s.song_id
        LEFT JOIN recording_songwriters rsw ON rsw.recording_id = r.recording_id
        LEFT JOIN artists aw ON aw.artist_id = rsw.artist_id
        LEFT JOIN recording_producers rp ON rp.recording_id = r.recording_id
        LEFT JOIN artists ap ON ap.artist_id = rp.artist_id
        WHERE s.title LIKE :q1 OR aw.name LIKE :q2 OR ap.name LIKE :q3
        ORDER BY s.title
    ");
    $songStmt->execute(['q1' => $like, 'q2' => $like, 'q3' => $like]);
    $songs = $songStmt->fetchAll(PDO::FETCH_ASSOC);

    $appearanceStmt = $pdo->prepare("
        SELECT al.album_id, al.title AS album_title, at.track_number,
               r.version_type, r.recording_id, r.duration_seconds
        FROM recordings r
        JOIN album_tracks at ON at.recording_id = r.recording_id
        JOIN albums al ON al.album_id = at.album_id
        WHERE r.song_id = :songId
        ORDER BY al.release_date, at.track_number
    ");

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

    foreach ($songs as $song) {
        $appearanceStmt->execute(['songId' => $song['song_id']]);
        $appearances = $appearanceStmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($appearances as &$appearance) {
            $creditStmt->execute([
                'recId1' => $appearance['recording_id'],
                'recId2' => $appearance['recording_id'],
            ]);
            $appearance['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);
        }

        $song['appearances'] = $appearances;
        $song['recording_count'] = count($appearances);
        $results[] = $song;
    }
}

$pageTitle = 'Search — Taylor Swift Catalogue';
$currentNav = 'search';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Search</h1>
        <form class="search-form" method="get" action="search.php">
            <label class="visually-hidden" for="q">Song, songwriter, or producer</label>
            <input type="text" id="q" name="q" value="<?= htmlspecialchars($query) ?>" placeholder="Song, songwriter, or producer...">
            <button type="submit">Search</button>
        </form>

        <?php if ($query !== ''): ?>
            <p class="muted"><?= count($results) ?> song(s) matching "<?= htmlspecialchars($query) ?>"</p>

            <?php foreach ($results as $song): ?>
            <div class="result-card">
                <h2>
                    <a href="song.php?song_id=<?= (int) $song['song_id'] ?>"><?= htmlspecialchars($song['title']) ?></a>
                    <?= favourite_toggle_html((int) $song['song_id'], $song['title']) ?>
                    <?php if ($song['recording_count'] > 1): ?>
                    <a href="compare.php?song_id=<?= (int) $song['song_id'] ?>">(compare versions)</a>
                    <?php endif; ?>
                </h2>
                <ul>
                    <?php foreach ($song['appearances'] as $appearance): ?>
                    <li>
                        <a href="tracklist.php?album_id=<?= (int) $appearance['album_id'] ?>">
                            <?= htmlspecialchars($appearance['album_title']) ?>
                        </a>
                        — track <?= htmlspecialchars($appearance['track_number']) ?>
                        (<?= htmlspecialchars($appearance['version_type']) ?>,
                        <?= $appearance['duration_seconds'] ? gmdate('i:s', $appearance['duration_seconds']) : '—' ?>)
                        — <?= htmlspecialchars(implode(', ', $appearance['credits'])) ?>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <?php include __DIR__ . '/scripts.php'; ?>
</body>
</html>
