<?php
// --- Database connection ---
require __DIR__ . '/config.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Each song's representative recording (preferring the original
// version, earliest release) — used to credit tournament wins back
// to an album for the results-screen statistics, and to show
// album/duration on any playlist generated from the results. Same
// "pick one representative recording" pattern as moods.php and
// song.php.
$songStmt = $pdo->query("
    SELECT s.song_id, s.title, al.album_id, al.title AS album, rep.duration_seconds
    FROM songs s
    LEFT JOIN recordings rep ON rep.recording_id = (
        SELECT r2.recording_id
        FROM recordings r2
        LEFT JOIN album_tracks at2 ON at2.recording_id = r2.recording_id
        LEFT JOIN albums al2 ON al2.album_id = at2.album_id
        WHERE r2.song_id = s.song_id
        ORDER BY (r2.version_type = 'original') DESC, al2.release_date, at2.track_number
        LIMIT 1
    )
    LEFT JOIN album_tracks at ON at.recording_id = rep.recording_id
    LEFT JOIN albums al ON al.album_id = at.album_id
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
    <script src="playlists.js" defer></script>
    <script src="tournament.js" defer></script>
</body>
</html>
