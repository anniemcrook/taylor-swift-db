<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/artwork.php';
require __DIR__ . '/helpers.php';

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
    SELECT at.track_number, s.song_id, s.title, r.recording_id, r.duration_seconds,
           r.music_video_url
    FROM album_tracks at
    JOIN recordings r ON at.recording_id = r.recording_id
    JOIN songs s ON r.song_id = s.song_id
    WHERE at.album_id = :albumId
    ORDER BY at.track_number
";

$stmt = $pdo->prepare($sql);
$stmt->execute(['albumId' => $albumId]);
$tracks = $stmt->fetchAll(PDO::FETCH_ASSOC);

// --- Songwriter/producer credits and recording count, per track ---
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
$recordingCountStmt = $pdo->prepare("SELECT COUNT(*) FROM recordings WHERE song_id = :songId");

// If this recording has no music video of its own, borrow one from
// another recording of the same song (e.g. a Taylor's Version track
// showing the original recording's video), preferring the original.
$borrowedVideoStmt = $pdo->prepare("
    SELECT music_video_url, version_type
    FROM recordings
    WHERE song_id = :songId
      AND recording_id != :recordingId
      AND music_video_url IS NOT NULL
    ORDER BY (version_type = 'original') DESC
    LIMIT 1
");

foreach ($tracks as &$track) {
    $creditStmt->execute(['recId1' => $track['recording_id'], 'recId2' => $track['recording_id']]);
    $track['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);

    $recordingCountStmt->execute(['songId' => $track['song_id']]);
    $track['recording_count'] = (int) $recordingCountStmt->fetchColumn();

    $track['video_note'] = null;
    if (!$track['music_video_url']) {
        $borrowedVideoStmt->execute([
            'songId' => $track['song_id'],
            'recordingId' => $track['recording_id'],
        ]);
        $borrowed = $borrowedVideoStmt->fetch(PDO::FETCH_ASSOC);
        if ($borrowed) {
            $track['music_video_url'] = $borrowed['music_video_url'];
            $track['video_note'] = format_version_type($borrowed['version_type']);
        }
    }
}
unset($track);

$artwork = get_album_artwork($pdo, $albumId, $album['title']);

$pageTitle = $album['title'] . ' — Tracklist';
$currentNav = null;
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1><?= htmlspecialchars($album['title']) ?></h1>
        <?php if ($artwork): ?>
        <img class="album-cover" src="<?= htmlspecialchars($artwork) ?>" width="240" height="240" alt="<?= htmlspecialchars($album['title']) ?> cover art">
        <?php endif; ?>
        <div class="table-wrap">
            <table>
                <caption class="visually-hidden"><?= htmlspecialchars($album['title']) ?> tracklist</caption>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Title</th>
                    <th scope="col">Duration</th>
                    <th scope="col">Credits</th>
                    <th scope="col">Music Video</th>
                </tr>
                <?php foreach ($tracks as $track): ?>
                <tr>
                    <td><?= htmlspecialchars($track['track_number']) ?></td>
                    <td>
                        <?= htmlspecialchars($track['title']) ?>
                        <?php if ($track['recording_count'] > 1): ?>
                        <a href="compare.php?song_id=<?= (int) $track['song_id'] ?>">(compare versions)</a>
                        <?php endif; ?>
                    </td>
                    <td><?= $track['duration_seconds'] ? gmdate('i:s', $track['duration_seconds']) : '—' ?></td>
                    <td><?= htmlspecialchars(implode(', ', $track['credits'])) ?></td>
                    <td>
                        <?php if ($track['music_video_url']): ?>
                        <a href="<?= htmlspecialchars($track['music_video_url']) ?>" target="_blank" rel="noopener">
                            Watch<span class="visually-hidden"> (opens in a new tab)</span>
                        </a>
                        <?php if ($track['video_note']): ?>
                        <span class="muted">(<?= htmlspecialchars($track['video_note']) ?>)</span>
                        <?php endif; ?>
                        <?php else: ?>
                        —
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>
    </main>
</body>
</html>
