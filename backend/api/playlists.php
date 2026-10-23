<?php
require __DIR__ . '/_bootstrap.php';

// Every response returns the user's full current playlist list, so
// the client can just re-render from the response rather than
// tracking its own merge logic on top of a partial update.
function fetch_playlists_for_user(PDO $pdo, int $userId): array
{
    $playlistStmt = $pdo->prepare('
        SELECT playlist_id, name, source, created_at
        FROM user_playlists
        WHERE user_id = :userId
        ORDER BY created_at
    ');
    $playlistStmt->execute(['userId' => $userId]);
    $playlists = $playlistStmt->fetchAll(PDO::FETCH_ASSOC);

    $songIdsStmt = $pdo->prepare('
        SELECT song_id FROM user_playlist_songs
        WHERE playlist_id = :playlistId
        ORDER BY position
    ');
    // Looks up a representative recording per song (preferring the
    // original, same rule song.php uses) for display — title/album/
    // duration are joined live from the catalogue, never snapshotted,
    // so they stay accurate if the catalogue data ever changes.
    $representativeStmt = $pdo->prepare("
        SELECT s.title, al.album_id, al.title AS album, r.duration_seconds
        FROM songs s
        LEFT JOIN recordings r ON r.song_id = s.song_id
        LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
        LEFT JOIN albums al ON al.album_id = at.album_id
        WHERE s.song_id = :songId
        ORDER BY (r.version_type = 'original') DESC, al.release_date, at.track_number
        LIMIT 1
    ");

    foreach ($playlists as &$playlist) {
        $playlist['playlist_id'] = (int) $playlist['playlist_id'];
        $songIdsStmt->execute(['playlistId' => $playlist['playlist_id']]);
        $songIds = $songIdsStmt->fetchAll(PDO::FETCH_COLUMN);

        $songs = [];
        foreach ($songIds as $songId) {
            $representativeStmt->execute(['songId' => $songId]);
            $row = $representativeStmt->fetch(PDO::FETCH_ASSOC) ?: [];
            $songs[] = [
                'song_id' => (int) $songId,
                'title' => $row['title'] ?? null,
                'album_id' => isset($row['album_id']) ? (int) $row['album_id'] : null,
                'album' => $row['album'] ?? null,
                'duration_seconds' => isset($row['duration_seconds']) ? (int) $row['duration_seconds'] : null,
            ];
        }
        $playlist['songs'] = $songs;
    }
    unset($playlist);

    return $playlists;
}

// Validates and dedupes to catalogue song_ids that actually exist —
// a locally-saved playlist can reference a song_id that's since been
// removed from the catalogue (unlikely, but not impossible).
function valid_song_ids(PDO $pdo, array $songIds): array
{
    $checkStmt = $pdo->prepare('SELECT 1 FROM songs WHERE song_id = :id');
    $valid = [];
    foreach ($songIds as $songId) {
        $songId = (int) $songId;
        $checkStmt->execute(['id' => $songId]);
        if ($checkStmt->fetch()) {
            $valid[] = $songId;
        }
    }
    return $valid;
}

function insert_playlist(PDO $pdo, int $userId, string $name, ?string $source, array $songIds): void
{
    $pdo->beginTransaction();
    $insertPlaylistStmt = $pdo->prepare('INSERT INTO user_playlists (user_id, name, source) VALUES (:userId, :name, :source)');
    $insertPlaylistStmt->execute(['userId' => $userId, 'name' => $name, 'source' => $source]);
    $playlistId = (int) $pdo->lastInsertId();
    $insertSongStmt = $pdo->prepare('INSERT INTO user_playlist_songs (playlist_id, position, song_id) VALUES (:playlistId, :position, :songId)');
    foreach ($songIds as $position => $songId) {
        $insertSongStmt->execute(['playlistId' => $playlistId, 'position' => $position, 'songId' => $songId]);
    }
    $pdo->commit();
}

$action = $apiInput['action'] ?? '';

if ($action === 'list') {
    echo json_encode(['ok' => true, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
    exit;
}

if ($action === 'create') {
    $name = trim((string) ($apiInput['name'] ?? ''));
    $source = isset($apiInput['source']) ? (string) $apiInput['source'] : null;
    $songIds = $apiInput['song_ids'] ?? [];

    if ($name === '') {
        api_fail(400, 'Enter a playlist name.');
    }
    if (strlen($name) > 255) {
        api_fail(400, 'Playlist name must be 255 characters or fewer.');
    }
    if (!is_array($songIds) || $songIds === []) {
        api_fail(400, 'A playlist needs at least one song.');
    }

    $validSongIds = valid_song_ids($pdo, $songIds);
    if ($validSongIds === []) {
        api_fail(400, 'None of those songs exist.');
    }

    insert_playlist($pdo, $apiUser['user_id'], $name, $source, $validSongIds);
    echo json_encode(['ok' => true, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
    exit;
}

if ($action === 'delete') {
    $playlistId = (int) ($apiInput['playlist_id'] ?? 0);
    $ownStmt = $pdo->prepare('SELECT 1 FROM user_playlists WHERE playlist_id = :id AND user_id = :userId');
    $ownStmt->execute(['id' => $playlistId, 'userId' => $apiUser['user_id']]);
    if ($ownStmt->fetch()) {
        $pdo->prepare('DELETE FROM user_playlist_songs WHERE playlist_id = :id')->execute(['id' => $playlistId]);
        $pdo->prepare('DELETE FROM user_playlists WHERE playlist_id = :id')->execute(['id' => $playlistId]);
    }
    echo json_encode(['ok' => true, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
    exit;
}

if ($action === 'remove_song') {
    $playlistId = (int) ($apiInput['playlist_id'] ?? 0);
    $position = (int) ($apiInput['position'] ?? -1);

    $ownStmt = $pdo->prepare('SELECT 1 FROM user_playlists WHERE playlist_id = :id AND user_id = :userId');
    $ownStmt->execute(['id' => $playlistId, 'userId' => $apiUser['user_id']]);
    if ($ownStmt->fetch()) {
        // Positions have to stay contiguous (0..n-1) after a removal
        // — the client identifies a song to remove by its position,
        // same as the localStorage version did by array index.
        $pdo->beginTransaction();
        $remainingStmt = $pdo->prepare('SELECT song_id FROM user_playlist_songs WHERE playlist_id = :id AND position != :position ORDER BY position');
        $remainingStmt->execute(['id' => $playlistId, 'position' => $position]);
        $remainingSongIds = $remainingStmt->fetchAll(PDO::FETCH_COLUMN);

        $pdo->prepare('DELETE FROM user_playlist_songs WHERE playlist_id = :id')->execute(['id' => $playlistId]);
        $insertStmt = $pdo->prepare('INSERT INTO user_playlist_songs (playlist_id, position, song_id) VALUES (:id, :position, :songId)');
        foreach ($remainingSongIds as $newPosition => $songId) {
            $insertStmt->execute(['id' => $playlistId, 'position' => $newPosition, 'songId' => $songId]);
        }
        $pdo->commit();
    }
    echo json_encode(['ok' => true, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
    exit;
}

if ($action === 'import') {
    // One-time copy from localStorage, only when the account has no
    // server-side playlists yet — re-checked here, not just trusted
    // from the client, so calling this more than once is harmless.
    $existingStmt = $pdo->prepare('SELECT COUNT(*) FROM user_playlists WHERE user_id = :userId');
    $existingStmt->execute(['userId' => $apiUser['user_id']]);
    if ((int) $existingStmt->fetchColumn() > 0) {
        echo json_encode(['ok' => true, 'imported' => 0, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
        exit;
    }

    $localPlaylists = $apiInput['playlists'] ?? [];
    if (!is_array($localPlaylists)) {
        api_fail(400, 'playlists must be an array.');
    }

    $imported = 0;
    foreach ($localPlaylists as $localPlaylist) {
        $name = trim((string) ($localPlaylist['name'] ?? ''));
        $source = isset($localPlaylist['source']) ? (string) $localPlaylist['source'] : null;
        $songIds = $localPlaylist['song_ids'] ?? [];
        if ($name === '' || !is_array($songIds) || $songIds === []) {
            continue;
        }
        $validSongIds = valid_song_ids($pdo, $songIds);
        if ($validSongIds === []) {
            continue;
        }
        // Truncate rather than reject — this is an automatic
        // migration the user doesn't get a chance to correct, so a
        // too-long name shouldn't silently drop the whole playlist.
        insert_playlist($pdo, $apiUser['user_id'], substr($name, 0, 255), $source, $validSongIds);
        $imported++;
    }
    echo json_encode(['ok' => true, 'imported' => $imported, 'playlists' => fetch_playlists_for_user($pdo, $apiUser['user_id'])]);
    exit;
}

api_fail(400, 'Unknown action.');
