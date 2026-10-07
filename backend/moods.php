<?php
// --- Database connection ---
require __DIR__ . '/config.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// --- Every theme, with how many recordings carry it ---
$themesStmt = $pdo->query("
    SELECT t.theme_id, t.name, COUNT(rt.recording_id) AS recording_count
    FROM themes t
    LEFT JOIN recording_themes rt ON rt.theme_id = t.theme_id
    GROUP BY t.theme_id, t.name
    ORDER BY t.name
");
$allThemes = $themesStmt->fetchAll(PDO::FETCH_ASSOC);

// --- Which themes are selected, from ?theme_id[]=1&theme_id[]=2 ---
$selectedThemeIds = [];
if (isset($_GET['theme_id']) && is_array($_GET['theme_id'])) {
    $selectedThemeIds = array_values(array_unique(array_map('intval', $_GET['theme_id'])));
}

$playlist = [];
if ($selectedThemeIds !== []) {
    $placeholders = implode(',', array_fill(0, count($selectedThemeIds), '?'));

    $playlistStmt = $pdo->prepare("
        SELECT r.recording_id, s.title AS song_title, r.version_type, r.duration_seconds,
               al.album_id, al.title AS album_title, at.track_number,
               COUNT(DISTINCT rt.theme_id) AS match_count
        FROM recording_themes rt
        JOIN recordings r ON r.recording_id = rt.recording_id
        JOIN songs s ON s.song_id = r.song_id
        LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
        LEFT JOIN albums al ON al.album_id = at.album_id
        WHERE rt.theme_id IN ($placeholders)
        GROUP BY r.recording_id, s.title, r.version_type, r.duration_seconds, al.album_id, al.title, at.track_number
        ORDER BY match_count DESC, al.release_date, at.track_number
    ");
    $playlistStmt->execute($selectedThemeIds);
    $playlist = $playlistStmt->fetchAll(PDO::FETCH_ASSOC);

    // Themes per matched recording, for context on *why* it matched.
    $themeListStmt = $pdo->prepare("
        SELECT t.name FROM recording_themes rt
        JOIN themes t ON t.theme_id = rt.theme_id
        WHERE rt.recording_id = :recordingId
        ORDER BY t.name
    ");
    foreach ($playlist as &$track) {
        $themeListStmt->execute(['recordingId' => $track['recording_id']]);
        $track['themes'] = $themeListStmt->fetchAll(PDO::FETCH_COLUMN);
    }
    unset($track);
}

$pageTitle = 'Moods — Taylor Swift Catalogue';
$currentNav = 'moods';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Moods</h1>
        <p class="muted">Pick one or more themes to build a playlist. Songs matching more of your selected themes are ranked first.</p>
        <form method="get" action="moods.php">
            <fieldset class="theme-picker">
                <legend class="visually-hidden">Themes</legend>
                <?php foreach ($allThemes as $theme): ?>
                <label class="theme-chip">
                    <input
                        type="checkbox"
                        name="theme_id[]"
                        value="<?= (int) $theme['theme_id'] ?>"
                        <?= in_array((int) $theme['theme_id'], $selectedThemeIds, true) ? 'checked' : '' ?>
                    >
                    <?= htmlspecialchars($theme['name']) ?>
                    <span class="muted">(<?= (int) $theme['recording_count'] ?>)</span>
                </label>
                <?php endforeach; ?>
            </fieldset>
            <button type="submit">Build Playlist</button>
        </form>

        <?php if ($selectedThemeIds !== []): ?>
        <h2><?= count($playlist) ?> track<?= count($playlist) === 1 ? '' : 's' ?></h2>
        <ol class="plain-list">
            <?php foreach ($playlist as $track): ?>
            <li>
                <strong><?= htmlspecialchars($track['song_title']) ?></strong>
                <span class="muted">(<?= htmlspecialchars($track['version_type']) ?>)</span>
                <?php if ($track['album_title']): ?>
                — <a href="tracklist.php?album_id=<?= (int) $track['album_id'] ?>"><?= htmlspecialchars($track['album_title']) ?></a>
                <?php endif; ?>
                <?php if ($track['duration_seconds']): ?>
                · <?= gmdate('i:s', $track['duration_seconds']) ?>
                <?php endif; ?>
                <br>
                <span class="tag muted">Themes: <?= htmlspecialchars(implode(', ', $track['themes'])) ?></span>
            </li>
            <?php endforeach; ?>
        </ol>
        <?php if ($playlist === []): ?>
        <p class="muted">No tracks tagged with that theme yet.</p>
        <?php endif; ?>
        <?php endif; ?>
    </main>
</body>
</html>
