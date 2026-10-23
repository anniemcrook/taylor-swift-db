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

// --- Headline counts ---
$totalAlbums = (int) $pdo->query("SELECT COUNT(*) FROM albums")->fetchColumn();
$totalSongs = (int) $pdo->query("SELECT COUNT(*) FROM songs")->fetchColumn();
$totalRecordings = (int) $pdo->query("SELECT COUNT(*) FROM recordings")->fetchColumn();
$totalThemes = (int) $pdo->query("SELECT COUNT(*) FROM themes")->fetchColumn();
$totalRuntimeSeconds = (int) $pdo->query("SELECT COALESCE(SUM(duration_seconds), 0) FROM recordings")->fetchColumn();
$songsWithVideo = (int) $pdo->query("SELECT COUNT(DISTINCT song_id) FROM recordings WHERE music_video_url IS NOT NULL")->fetchColumn();
$vaultTrackCount = (int) $pdo->query("SELECT COUNT(*) FROM album_tracks WHERE edition = 'From the Vault'")->fetchColumn();

// --- Per-album breakdown: track count, total runtime, average track length ---
$albumStmt = $pdo->query("
    SELECT al.album_id, al.title, al.release_date,
           COUNT(at.recording_id) AS track_count,
           SUM(r.duration_seconds) AS total_seconds,
           AVG(r.duration_seconds) AS avg_seconds
    FROM albums al
    JOIN album_tracks at ON at.album_id = al.album_id
    JOIN recordings r ON r.recording_id = at.recording_id
    GROUP BY al.album_id, al.title, al.release_date
    ORDER BY al.release_date
");
$albums = $albumStmt->fetchAll(PDO::FETCH_ASSOC);

$longestAlbum = null;
$shortestAlbum = null;
$albumLengthSum = 0;
foreach ($albums as $album) {
    $albumLengthSum += (int) $album['total_seconds'];
    if (!$longestAlbum || $album['total_seconds'] > $longestAlbum['total_seconds']) {
        $longestAlbum = $album;
    }
    if (!$shortestAlbum || $album['total_seconds'] < $shortestAlbum['total_seconds']) {
        $shortestAlbum = $album;
    }
}
$averageAlbumLength = $albums !== [] ? (int) round($albumLengthSum / count($albums)) : 0;

// --- Longest / shortest individual recordings ---
$longestSong = $pdo->query("
    SELECT s.song_id, s.title, r.version_type, r.duration_seconds
    FROM recordings r
    JOIN songs s ON s.song_id = r.song_id
    WHERE r.duration_seconds IS NOT NULL
    ORDER BY r.duration_seconds DESC
    LIMIT 1
")->fetch(PDO::FETCH_ASSOC);

$shortestSong = $pdo->query("
    SELECT s.song_id, s.title, r.version_type, r.duration_seconds
    FROM recordings r
    JOIN songs s ON s.song_id = r.song_id
    WHERE r.duration_seconds IS NOT NULL
    ORDER BY r.duration_seconds ASC
    LIMIT 1
")->fetch(PDO::FETCH_ASSOC);

// --- Collaborations: outside songwriters/producers (everyone but Taylor herself) ---
$collaboratorCount = (int) $pdo->query("
    SELECT COUNT(DISTINCT ar.artist_id)
    FROM artists ar
    JOIN (
        SELECT artist_id FROM recording_songwriters
        UNION
        SELECT artist_id FROM recording_producers
    ) c ON c.artist_id = ar.artist_id
    WHERE ar.name != 'Taylor Swift'
")->fetchColumn();

$topCollaboratorsStmt = $pdo->query("
    SELECT ar.name, COUNT(DISTINCT r.song_id) AS song_count
    FROM artists ar
    JOIN (
        SELECT artist_id, recording_id FROM recording_songwriters
        UNION
        SELECT artist_id, recording_id FROM recording_producers
    ) c ON c.artist_id = ar.artist_id
    JOIN recordings r ON r.recording_id = c.recording_id
    WHERE ar.name != 'Taylor Swift'
    GROUP BY ar.artist_id, ar.name
    ORDER BY song_count DESC, ar.name
    LIMIT 10
");
$topCollaborators = $topCollaboratorsStmt->fetchAll(PDO::FETCH_ASSOC);

// --- Most common themes, by number of distinct songs carrying them ---
$topThemesStmt = $pdo->query("
    SELECT t.theme_id, t.name, COUNT(DISTINCT r.song_id) AS song_count
    FROM themes t
    JOIN recording_themes rt ON rt.theme_id = t.theme_id
    JOIN recordings r ON r.recording_id = rt.recording_id
    GROUP BY t.theme_id, t.name
    ORDER BY song_count DESC, t.name
    LIMIT 12
");
$topThemes = $topThemesStmt->fetchAll(PDO::FETCH_ASSOC);

// --- Recordings by version type ---
$versionTypeStmt = $pdo->query("
    SELECT version_type, COUNT(*) AS cnt
    FROM recordings
    GROUP BY version_type
    ORDER BY cnt DESC
");
$versionTypes = $versionTypeStmt->fetchAll(PDO::FETCH_ASSOC);

function format_duration(int $seconds): string
{
    $hours = intdiv($seconds, 3600);
    $minutes = intdiv($seconds % 3600, 60);
    if ($hours > 0) {
        return "{$hours}h {$minutes}m";
    }
    return "{$minutes}m " . ($seconds % 60) . "s";
}

$pageTitle = 'Catalogue Statistics — Taylor Swift Catalogue';
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
        <h1>Catalogue Statistics</h1>

        <div class="stat-grid">
            <div class="stat-card">
                <span class="stat-number"><?= $totalAlbums ?></span>
                <span class="stat-label">Albums</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $totalSongs ?></span>
                <span class="stat-label">Songs</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $totalRecordings ?></span>
                <span class="stat-label">Recordings</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $totalThemes ?></span>
                <span class="stat-label">Themes tagged</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= format_duration($totalRuntimeSeconds) ?></span>
                <span class="stat-label">Combined runtime<br><span class="muted">(every recording, once each)</span></span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $songsWithVideo ?></span>
                <span class="stat-label">Songs with an official music video</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $vaultTrackCount ?></span>
                <span class="stat-label">"From the Vault" tracks</span>
            </div>
            <div class="stat-card">
                <span class="stat-number"><?= $collaboratorCount ?></span>
                <span class="stat-label">Outside songwriters/producers</span>
            </div>
        </div>

        <h2>Albums</h2>
        <p class="muted">
            Average album length: <?= format_duration($averageAlbumLength) ?>.
            Longest: <a href="tracklist.php?album_id=<?= (int) $longestAlbum['album_id'] ?>"><?= htmlspecialchars($longestAlbum['title']) ?></a>
            (<?= format_duration((int) $longestAlbum['total_seconds']) ?>).
            Shortest: <a href="tracklist.php?album_id=<?= (int) $shortestAlbum['album_id'] ?>"><?= htmlspecialchars($shortestAlbum['title']) ?></a>
            (<?= format_duration((int) $shortestAlbum['total_seconds']) ?>).
        </p>
        <div class="table-wrap">
            <table>
                <caption class="visually-hidden">Per-album statistics</caption>
                <tr>
                    <th scope="col">Album</th>
                    <th scope="col">Tracks</th>
                    <th scope="col">Total length</th>
                    <th scope="col">Avg. track length</th>
                </tr>
                <?php foreach ($albums as $album): ?>
                <tr>
                    <td><a href="tracklist.php?album_id=<?= (int) $album['album_id'] ?>"><?= htmlspecialchars($album['title']) ?></a></td>
                    <td><?= (int) $album['track_count'] ?></td>
                    <td><?= format_duration((int) $album['total_seconds']) ?></td>
                    <td><?= gmdate('i:s', (int) round($album['avg_seconds'])) ?></td>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>

        <h2>Songs</h2>
        <p class="muted">
            Longest recording:
            <a href="song.php?song_id=<?= (int) $longestSong['song_id'] ?>"><?= htmlspecialchars($longestSong['title']) ?></a>
            (<?= htmlspecialchars(format_version_type($longestSong['version_type'])) ?>, <?= gmdate('i:s', $longestSong['duration_seconds']) ?>).
            Shortest:
            <a href="song.php?song_id=<?= (int) $shortestSong['song_id'] ?>"><?= htmlspecialchars($shortestSong['title']) ?></a>
            (<?= htmlspecialchars(format_version_type($shortestSong['version_type'])) ?>, <?= gmdate('i:s', $shortestSong['duration_seconds']) ?>).
        </p>

        <h2>Collaborations</h2>
        <p class="muted"><?= $collaboratorCount ?> different outside songwriters and producers have worked on this catalogue. Most frequent:</p>
        <ul class="plain-list">
            <?php foreach ($topCollaborators as $collaborator): ?>
            <li><a href="search.php?q=<?= urlencode($collaborator['name']) ?>"><?= htmlspecialchars($collaborator['name']) ?></a> <span class="tag muted">(<?= (int) $collaborator['song_count'] ?> songs)</span></li>
            <?php endforeach; ?>
        </ul>

        <h2>Themes &amp; moods</h2>
        <p class="muted">The most common themes across the catalogue, by number of distinct songs carrying them — see <a href="moods.php">Moods</a> for the full list and to build a playlist.</p>
        <ul class="plain-list">
            <?php foreach ($topThemes as $theme): ?>
            <li>
                <a href="moods.php?theme_id[]=<?= (int) $theme['theme_id'] ?>"><?= htmlspecialchars($theme['name']) ?></a>
                <span class="tag muted">(<?= (int) $theme['song_count'] ?> songs)</span>
            </li>
            <?php endforeach; ?>
        </ul>

        <h2>Versions &amp; editions</h2>
        <ul class="plain-list">
            <?php foreach ($versionTypes as $vt): ?>
            <li><a href="version.php?type=<?= urlencode($vt['version_type']) ?>"><?= htmlspecialchars(format_version_type($vt['version_type'])) ?></a> <span class="tag muted">(<?= (int) $vt['cnt'] ?>)</span></li>
            <?php endforeach; ?>
        </ul>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
