<?php
// --- Database connection ---
require __DIR__ . '/config.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$songId = isset($_GET['song_id']) ? (int) $_GET['song_id'] : 0;

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

if ($songId !== 0) {
    // --- Detail view: every recording of this one song, side by side ---
    $songStmt = $pdo->prepare("SELECT title FROM songs WHERE song_id = :id");
    $songStmt->execute(['id' => $songId]);
    $song = $songStmt->fetch(PDO::FETCH_ASSOC);

    if (!$song) {
        die("No song found with that ID.");
    }

    $recordingStmt = $pdo->prepare("
        SELECT r.recording_id, r.version_type, r.duration_seconds,
               al.album_id, al.title AS album_title, at.track_number
        FROM recordings r
        LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
        LEFT JOIN albums al ON al.album_id = at.album_id
        WHERE r.song_id = :songId
        ORDER BY al.release_date, at.track_number
    ");
    $recordingStmt->execute(['songId' => $songId]);
    $recordings = $recordingStmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($recordings as &$recording) {
        $creditStmt->execute([
            'recId1' => $recording['recording_id'],
            'recId2' => $recording['recording_id'],
        ]);
        $recording['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);
    }
    unset($recording);
}

if ($songId === 0) {
    // --- List view: every song that has more than one recording ---
    $listStmt = $pdo->query("
        SELECT s.song_id, s.title, COUNT(*) AS recording_count
        FROM songs s
        JOIN recordings r ON r.song_id = s.song_id
        GROUP BY s.song_id, s.title
        HAVING COUNT(*) > 1
        ORDER BY s.title
    ");
    $songsWithMultipleRecordings = $listStmt->fetchAll(PDO::FETCH_ASSOC);
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Compare Versions — Taylor Swift Catalogue</title>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>

    <?php if ($songId === 0): ?>
        <h1>Compare Versions</h1>
        <p>Pick a song that has more than one recording to compare them side by side.</p>
        <ul>
            <?php foreach ($songsWithMultipleRecordings as $s): ?>
            <li>
                <a href="compare.php?song_id=<?= (int) $s['song_id'] ?>">
                    <?= htmlspecialchars($s['title']) ?>
                </a>
                (<?= (int) $s['recording_count'] ?> recordings)
            </li>
            <?php endforeach; ?>
        </ul>
    <?php else: ?>
        <h1><?= htmlspecialchars($song['title']) ?> — Version Comparison</h1>
        <table border="1" cellpadding="8">
            <tr>
                <th>Version</th>
                <th>Album</th>
                <th>Track #</th>
                <th>Duration</th>
                <th>Credits</th>
            </tr>
            <?php foreach ($recordings as $recording): ?>
            <tr>
                <td><?= htmlspecialchars($recording['version_type']) ?></td>
                <td>
                    <?php if ($recording['album_id']): ?>
                    <a href="tracklist.php?album_id=<?= (int) $recording['album_id'] ?>">
                        <?= htmlspecialchars($recording['album_title']) ?>
                    </a>
                    <?php else: ?>
                    —
                    <?php endif; ?>
                </td>
                <td><?= htmlspecialchars($recording['track_number'] ?? '—') ?></td>
                <td><?= $recording['duration_seconds'] ? gmdate('i:s', $recording['duration_seconds']) : '—' ?></td>
                <td><?= htmlspecialchars(implode(', ', $recording['credits'])) ?></td>
            </tr>
            <?php endforeach; ?>
        </table>
    <?php endif; ?>
</body>
</html>
