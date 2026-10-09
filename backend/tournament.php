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

// One entity per *recording*, not per song — the original and the
// Taylor's Version (and any acoustic/remix/demo/extended take) are
// genuinely different recordings with their own fans, same
// reasoning as why themes are tagged per recording rather than per
// song (sql/0003_add_themes.sql). "Style" fans who specifically
// prefer the original's production over the Taylor's Version remix
// need to be able to vote for that recording, not an ambiguous
// merged "Style".
$recordingStmt = $pdo->query("
    SELECT r.recording_id, r.song_id, s.title AS song_title, r.version_type,
           r.duration_seconds, al.album_id, al.title AS album
    FROM recordings r
    JOIN songs s ON s.song_id = r.song_id
    LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
    LEFT JOIN albums al ON al.album_id = at.album_id
    ORDER BY r.recording_id
");
$recordings = $recordingStmt->fetchAll(PDO::FETCH_ASSOC);

// The original recording keeps the bare song title; every other
// version gets a plain-English suffix, e.g. "Style (Taylor's
// Version)" or "All Too Well (Extended Version)".
foreach ($recordings as &$recording) {
    if ($recording['version_type'] === 'original') {
        $recording['title'] = $recording['song_title'];
    } else {
        $recording['title'] = $recording['song_title'] . ' (' . ucwords(format_version_type($recording['version_type'])) . ')';
    }
    unset($recording['song_title'], $recording['version_type']);
}
unset($recording);
$songs = $recordings;

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
            Pick a winner between two, over and over, until one is
            left standing. This covers all <?= count($songs) ?>
            recordings in the catalogue — the original and the
            Taylor's Version (and any acoustic/remix/demo take) each
            get their own entry, since fans often prefer one specific
            recording of a song over another — so it's a long haul.
            Your progress is saved automatically in this browser, so
            you can close the tab and pick up right where you left off.
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
