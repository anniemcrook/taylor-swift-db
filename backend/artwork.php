<?php
// Looks up album artwork via the iTunes Search API (no API key needed)
// and caches the result in albums.cover_url so each album only ever
// hits the network once.
function get_album_artwork(PDO $pdo, int $albumId, string $title): ?string
{
    $stmt = $pdo->prepare('SELECT cover_url FROM albums WHERE album_id = :id');
    $stmt->execute(['id' => $albumId]);
    $cached = $stmt->fetchColumn();
    if ($cached) {
        return $cached;
    }

    $term = urlencode('Taylor Swift ' . $title);
    $url = "https://itunes.apple.com/search?term={$term}&entity=album&limit=5";

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);
    curl_setopt($ch, CURLOPT_USERAGENT, 'taylor-swift-db/1.0');
    $response = curl_exec($ch);
    curl_close($ch);

    if (!$response) {
        return null;
    }

    $data = json_decode($response, true);
    if (empty($data['results'])) {
        return null;
    }

    // iTunes' relevance ranking doesn't always put the exact album we
    // asked for first (e.g. a "Speak Now" query can rank "Speak Now
    // (Taylor's Version)" above the plain original) — so prefer an
    // exact title match by Taylor Swift, and only fall back to "first
    // result credited to Taylor Swift" if nothing matches exactly.
    $match = null;
    foreach ($data['results'] as $result) {
        if (($result['artistName'] ?? '') === 'Taylor Swift'
            && strcasecmp($result['collectionName'] ?? '', $title) === 0) {
            $match = $result;
            break;
        }
    }
    if (!$match) {
        foreach ($data['results'] as $result) {
            if (($result['artistName'] ?? '') === 'Taylor Swift') {
                $match = $result;
                break;
            }
        }
    }
    $match ??= $data['results'][0];

    $artworkUrl = $match['artworkUrl100'] ?? null;
    if (!$artworkUrl) {
        return null;
    }

    // iTunes serves a small thumbnail by default; ask for a bigger one.
    $artworkUrl = str_replace('100x100bb', '600x600bb', $artworkUrl);

    $update = $pdo->prepare('UPDATE albums SET cover_url = :url WHERE album_id = :id');
    $update->execute(['url' => $artworkUrl, 'id' => $albumId]);

    return $artworkUrl;
}
