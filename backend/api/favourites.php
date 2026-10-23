<?php
require __DIR__ . '/_bootstrap.php';

$action = $apiInput['action'] ?? '';

if ($action === 'list') {
    $stmt = $pdo->prepare('
        SELECT uf.song_id, s.title
        FROM user_favourites uf
        JOIN songs s ON s.song_id = uf.song_id
        WHERE uf.user_id = :userId
    ');
    $stmt->execute(['userId' => $apiUser['user_id']]);
    $favourites = [];
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
        $favourites[(string) $row['song_id']] = $row['title'];
    }
    echo json_encode(['ok' => true, 'favourites' => $favourites]);
    exit;
}

if ($action === 'add') {
    $songId = (int) ($apiInput['song_id'] ?? 0);
    $songStmt = $pdo->prepare('SELECT title FROM songs WHERE song_id = :id');
    $songStmt->execute(['id' => $songId]);
    $song = $songStmt->fetch(PDO::FETCH_ASSOC);
    if (!$song) {
        api_fail(400, 'That song does not exist.');
    }
    $insertStmt = $pdo->prepare('INSERT IGNORE INTO user_favourites (user_id, song_id) VALUES (:userId, :songId)');
    $insertStmt->execute(['userId' => $apiUser['user_id'], 'songId' => $songId]);
    echo json_encode(['ok' => true, 'title' => $song['title']]);
    exit;
}

if ($action === 'remove') {
    $songId = (int) ($apiInput['song_id'] ?? 0);
    $deleteStmt = $pdo->prepare('DELETE FROM user_favourites WHERE user_id = :userId AND song_id = :songId');
    $deleteStmt->execute(['userId' => $apiUser['user_id'], 'songId' => $songId]);
    echo json_encode(['ok' => true]);
    exit;
}

if ($action === 'import') {
    // One-time copy from a browser's localStorage into the account,
    // the first time this user logs in with local favourites and no
    // server-side ones yet. Re-checked here, not just trusted from
    // the client, so this can never clobber or duplicate existing
    // server data if called more than once.
    $existingStmt = $pdo->prepare('SELECT COUNT(*) FROM user_favourites WHERE user_id = :userId');
    $existingStmt->execute(['userId' => $apiUser['user_id']]);
    if ((int) $existingStmt->fetchColumn() > 0) {
        echo json_encode(['ok' => true, 'imported' => 0]);
        exit;
    }

    $songIds = $apiInput['song_ids'] ?? [];
    if (!is_array($songIds)) {
        api_fail(400, 'song_ids must be an array.');
    }

    $insertStmt = $pdo->prepare('INSERT IGNORE INTO user_favourites (user_id, song_id) VALUES (:userId, :songId)');
    $checkStmt = $pdo->prepare('SELECT 1 FROM songs WHERE song_id = :id');
    $imported = 0;
    foreach ($songIds as $songId) {
        $songId = (int) $songId;
        $checkStmt->execute(['id' => $songId]);
        if (!$checkStmt->fetch()) {
            continue; // a locally-favourited song that no longer exists in the catalogue
        }
        $insertStmt->execute(['userId' => $apiUser['user_id'], 'songId' => $songId]);
        $imported++;
    }
    echo json_encode(['ok' => true, 'imported' => $imported]);
    exit;
}

api_fail(400, 'Unknown action.');
