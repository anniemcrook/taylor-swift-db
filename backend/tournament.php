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
// Version)". One recording needs its exact real-world title rather
// than the generic rule: the "All Too Well" 10-minute cut isn't
// just "the extended version" to fans, it's specifically "All Too
// Well (10 Minute Version) (Taylor's Version) [From the Vault]" —
// hardcoded here rather than generalized, since "10 Minute Version"
// isn't a label this schema can derive for any other song, and
// labelling vault tracks generally was explicitly deferred by the
// user as "unnecessary for now" (see TASKS.md backlog).
foreach ($recordings as &$recording) {
    if ($recording['song_title'] === 'All Too Well' && $recording['version_type'] === 'other') {
        $recording['title'] = "All Too Well (10 Minute Version) (Taylor's Version) [From the Vault]";
    } elseif ($recording['version_type'] === 'original') {
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
        </p>
        <p class="muted">
            This is double-elimination, not single: losing once drops
            a song into a Losers Bracket for a second chance, rather
            than knocking it out for good — so a song unlucky enough
            to face one of your favourites early isn't automatically
            gone. If you genuinely don't like or know either song in
            a matchup, "Reject both" drops them for good instead of
            forcing a pick. Your progress is saved automatically in
            this browser, so you can close the tab and pick up right
            where you left off.
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
