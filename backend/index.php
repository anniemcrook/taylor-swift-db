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

$stmt = $pdo->query("SELECT album_id, title FROM albums ORDER BY release_date");
$albums = $stmt->fetchAll(PDO::FETCH_ASSOC);

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
    </main>
</body>
</html>
