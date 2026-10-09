<?php
// --- Database connection ---
require __DIR__ . '/config.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Each song's representative album (preferring the original
// version, earliest release) — used to credit tournament wins back
// to an album for the results-screen statistics. Same "pick one
// representative recording" pattern as moods.php and song.php.
$songStmt = $pdo->query("
    SELECT s.song_id, s.title,
        (SELECT al.title
            FROM recordings r
            LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
            LEFT JOIN albums al ON al.album_id = at.album_id
            WHERE r.song_id = s.song_id
            ORDER BY (r.version_type = 'original') DESC, al.release_date, at.track_number
            LIMIT 1) AS album
    FROM songs s
    ORDER BY s.song_id
");
$songs = $songStmt->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = 'Favourite Song Tournament — Taylor Swift Catalogue';
$currentNav = 'tournament';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Favourite Song Tournament</h1>
        <p class="muted">
            Pick a winner between two songs, over and over, until one
            song is left standing. This covers all <?= count($songs) ?>
            songs in the catalogue, so it's a long haul — your progress
            is saved automatically in this browser, so you can close
            the tab and pick up right where you left off.
        </p>

        <noscript>
            <p class="muted">The tournament needs JavaScript enabled to run, since your progress is saved in your browser rather than on the server.</p>
        </noscript>

        <div id="tournament-root"></div>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <script>window.TS_SONGS = <?= json_encode($songs, JSON_HEX_TAG) ?>;</script>
    <script src="tournament.js" defer></script>
</body>
</html>
