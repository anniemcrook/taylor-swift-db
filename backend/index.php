<?php
// --- Database connection ---
require __DIR__ . '/config.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$stmt = $pdo->query("SELECT album_id, title FROM albums ORDER BY release_date");
$albums = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <title>Taylor Swift Catalogue</title>
</head>
<body>
    <h1>Taylor Swift Catalogue</h1>
    <ul>
        <?php foreach ($albums as $album): ?>
        <li>
            <a href="tracklist.php?album_id=<?= (int) $album['album_id'] ?>">
                <?= htmlspecialchars($album['title']) ?>
            </a>
        </li>
        <?php endforeach; ?>
    </ul>
</body>
</html>
