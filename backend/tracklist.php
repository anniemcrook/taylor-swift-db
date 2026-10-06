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

// --- Read the album ID from the URL, e.g. tracklist.php?album_id=2 ---
// (int) cast forces it to a number — if someone types something weird in
// the URL, it becomes 0 rather than being passed through as raw text.
$albumId = isset($_GET['album_id']) ? (int) $_GET['album_id'] : 0;

if ($albumId === 0) {
    die("Please provide an album, e.g. tracklist.php?album_id=1");
}

// --- Look up the album's own title, so the page heading is dynamic too ---
$albumStmt = $pdo->prepare("SELECT title FROM albums WHERE album_id = :albumId");
$albumStmt->execute(['albumId' => $albumId]);
$album = $albumStmt->fetch(PDO::FETCH_ASSOC);

if (!$album) {
    die("No album found with that ID.");
}

// --- The tracklist query, now parameterized instead of hardcoded ---
$sql = "
    SELECT at.track_number, s.title, r.duration_seconds
    FROM album_tracks at
    JOIN recordings r ON at.recording_id = r.recording_id
    JOIN songs s ON r.song_id = s.song_id
    WHERE at.album_id = :albumId
    ORDER BY at.track_number
";

$stmt = $pdo->prepare($sql);
$stmt->execute(['albumId' => $albumId]);
$tracks = $stmt->fetchAll(PDO::FETCH_ASSOC);

$artwork = get_album_artwork($pdo, $albumId, $album['title']);
?>
<!DOCTYPE html>
<html>
<head>
    <title><?= htmlspecialchars($album['title']) ?> — Tracklist</title>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <h1><?= htmlspecialchars($album['title']) ?></h1>
    <?php if ($artwork): ?>
    <img src="<?= htmlspecialchars($artwork) ?>" width="300" height="300" alt="<?= htmlspecialchars($album['title']) ?> cover art">
    <?php endif; ?>
    <table border="1" cellpadding="8">
        <tr>
            <th>#</th>
            <th>Title</th>
            <th>Duration</th>
        </tr>
        <?php foreach ($tracks as $track): ?>
        <tr>
            <td><?= htmlspecialchars($track['track_number']) ?></td>
            <td><?= htmlspecialchars($track['title']) ?></td>
            <td><?= $track['duration_seconds'] ? gmdate('i:s', $track['duration_seconds']) : '—' ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
