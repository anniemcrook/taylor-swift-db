<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/auth.php';
require __DIR__ . '/artwork.php';
require __DIR__ . '/helpers.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Eras group a studio album with its Taylor's Version re-recording
// as one unit — the grouping that actually matters to fans, rather
// than listing all 16 album rows flat. Ordered by each era's
// earliest release (the original album), with the original before
// its re-recording within the era.
$eraStmt = $pdo->query("
    SELECT e.era_id, e.name AS era_name, e.icon,
           al.album_id, al.title AS album_title, al.album_type, al.release_date
    FROM eras e
    JOIN albums al ON al.era_id = e.era_id
    ORDER BY (SELECT MIN(a2.release_date) FROM albums a2 WHERE a2.era_id = e.era_id), al.release_date
");
$eraRows = $eraStmt->fetchAll(PDO::FETCH_ASSOC);

$eras = [];
foreach ($eraRows as $row) {
    $eraId = (int) $row['era_id'];
    if (!isset($eras[$eraId])) {
        $eras[$eraId] = [
            'name' => $row['era_name'],
            'icon' => $row['icon'],
            'albums' => [],
        ];
    }
    $eras[$eraId]['albums'][] = $row;
}

// Non-album singles and soundtrack songs don't belong to any era —
// they get their own small list further down.
$singlesStmt = $pdo->query("
    SELECT al.album_id, al.title, s.song_id
    FROM albums al
    JOIN album_tracks at ON at.album_id = al.album_id
    JOIN recordings r ON r.recording_id = at.recording_id
    JOIN songs s ON s.song_id = r.song_id
    WHERE al.era_id IS NULL
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
        <h1>Eras</h1>
        <p class="muted intro-text">
            Every studio album, grouped the way it actually matters to
            fans — a re-recording sits with the era it belongs to, not
            off on its own by release date. Pick an era to browse its
            tracklist, or use <a href="search.php">Search</a> and
            <a href="moods.php">Moods</a> to cut across all of them.
        </p>
        <ul class="era-grid">
            <?php foreach ($eras as $era): ?>
            <li class="era-card" style="--era-accent: <?= htmlspecialchars(era_accent_color($era['name'])) ?>;">
                <div class="era-header">
                    <span class="era-icon" aria-hidden="true"><?= htmlspecialchars($era['icon'] ?? '') ?></span>
                    <span class="era-name"><?= htmlspecialchars($era['name']) ?></span>
                </div>
                <div class="era-albums">
                    <?php foreach ($era['albums'] as $album): ?>
                    <?php $artwork = get_album_artwork($pdo, (int) $album['album_id'], $album['album_title']); ?>
                    <a class="era-album" href="tracklist.php?album_id=<?= (int) $album['album_id'] ?>">
                        <?php if ($artwork): ?>
                        <img class="cover" src="<?= htmlspecialchars($artwork) ?>" width="120" height="120" alt="<?= htmlspecialchars($album['album_title']) ?> cover art">
                        <?php else: ?>
                        <span class="cover placeholder" aria-hidden="true">No artwork</span>
                        <?php endif; ?>
                        <?php if (count($era['albums']) > 1): ?>
                        <span class="era-album-label"><?= $album['album_type'] === 'taylors_version' ? "Taylor's Version" : 'Original' ?></span>
                        <?php endif; ?>
                    </a>
                    <?php endforeach; ?>
                </div>
            </li>
            <?php endforeach; ?>
        </ul>

        <?php if ($singles !== []): ?>
        <h2>Non-album singles &amp; soundtrack songs</h2>
        <p class="muted">Standalone releases that were never part of a numbered studio album, so they don't belong to any era.</p>
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
