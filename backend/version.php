<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/helpers.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Matches the recordings.version_type enum in sql/schema.sql.
$validTypes = ['original', 'taylors_version', 'live', 'remix', 'acoustic', 'demo', 'other'];

$versionType = isset($_GET['type']) ? (string) $_GET['type'] : '';

if (!in_array($versionType, $validTypes, true)) {
    die("Please provide a valid version type, e.g. version.php?type=original");
}

$stmt = $pdo->prepare("
    SELECT s.song_id, s.title, r.duration_seconds,
           al.album_id, al.title AS album_title, at.track_number
    FROM recordings r
    JOIN songs s ON s.song_id = r.song_id
    LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
    LEFT JOIN albums al ON al.album_id = at.album_id
    WHERE r.version_type = :type
    ORDER BY al.release_date, at.track_number, s.title
");
$stmt->execute(['type' => $versionType]);
$recordings = $stmt->fetchAll(PDO::FETCH_ASSOC);

$label = format_version_type($versionType);

$pageTitle = ucfirst($label) . ' recordings — Taylor Swift Catalogue';
$currentNav = 'stats';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1><?= htmlspecialchars(ucfirst($label)) ?> recordings</h1>
        <p class="muted"><?= count($recordings) ?> recording<?= count($recordings) === 1 ? '' : 's' ?> · <a href="stats.php">back to Statistics</a></p>

        <ul class="plain-list">
            <?php foreach ($recordings as $recording): ?>
            <li>
                <a href="song.php?song_id=<?= (int) $recording['song_id'] ?>"><strong><?= htmlspecialchars($recording['title']) ?></strong></a>
                <?= favourite_toggle_html((int) $recording['song_id'], $recording['title']) ?>
                <?php if ($recording['album_id']): ?>
                — <a href="tracklist.php?album_id=<?= (int) $recording['album_id'] ?>"><?= htmlspecialchars($recording['album_title']) ?></a>
                <?php endif; ?>
                <?php if ($recording['duration_seconds']): ?>
                · <?= gmdate('i:s', $recording['duration_seconds']) ?>
                <?php endif; ?>
            </li>
            <?php endforeach; ?>
        </ul>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <?php include __DIR__ . '/scripts.php'; ?>
</body>
</html>
