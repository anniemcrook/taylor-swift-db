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

$stmt = $pdo->query("
    SELECT album_id, title FROM albums
    WHERE album_type NOT IN ('single', 'soundtrack')
    ORDER BY release_date
");
$albums = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Non-album singles and soundtrack songs get their own small list
// further down rather than cluttering the main album grid — each is
// just a one-track "album" row, not a real album.
$singlesStmt = $pdo->query("
    SELECT al.album_id, al.title, s.song_id
    FROM albums al
    JOIN album_tracks at ON at.album_id = al.album_id
    JOIN recordings r ON r.recording_id = at.recording_id
    JOIN songs s ON s.song_id = r.song_id
    WHERE al.album_type IN ('single', 'soundtrack')
    ORDER BY al.release_date
");
$singles = $singlesStmt->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = 'Taylor Swift Catalogue';
$currentNav = 'home';
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Albums</h1>
        <ul class="album-grid">
            <?php foreach ($albums as $album): ?>
            <?php $artwork = get_album_artwork($pdo, (int) $album['album_id'], $album['title']); ?>
            <li>
                <a class="album-card" href="tracklist.php?album_id=<?= (int) $album['album_id'] ?>">
                    <?php if ($artwork): ?>
                    <img class="cover" src="<?= htmlspecialchars($artwork) ?>" width="150" height="150" alt="<?= htmlspecialchars($album['title']) ?> cover art">
                    <?php else: ?>
                    <span class="cover placeholder" aria-hidden="true">No artwork</span>
                    <?php endif; ?>
                    <span class="title"><?= htmlspecialchars($album['title']) ?></span>
                </a>
            </li>
            <?php endforeach; ?>
        </ul>

        <?php if ($singles !== []): ?>
        <h2>Non-album singles &amp; soundtrack songs</h2>
        <p class="muted">Standalone releases that were never part of a numbered studio album.</p>
        <ul class="plain-list">
            <?php foreach ($singles as $single): ?>
            <li><a href="song.php?song_id=<?= (int) $single['song_id'] ?>"><?= htmlspecialchars($single['title']) ?></a></li>
            <?php endforeach; ?>
        </ul>
        <?php endif; ?>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
