<?php
// Turns a recordings.version_type value into a readable label, for
// disambiguating which version a borrowed music video actually belongs to.
function format_version_type(string $versionType): string
{
    return match ($versionType) {
        'original' => 'original version',
        'taylors_version' => "Taylor's Version",
        'live' => 'live version',
        'remix' => 'remix',
        'acoustic' => 'acoustic version',
        'demo' => 'demo',
        'other' => 'extended version',
        default => $versionType,
    };
}

// Turns a recording into its fan-facing display title: the bare
// song title for the original, a plain-English version suffix for
// everything else (e.g. "Style (Taylor's Version)") — except the one
// recording that needs its exact real-world title rather than the
// generic rule, since the "All Too Well" 10-minute cut isn't just
// "the extended version" to fans. Hardcoded rather than generalized:
// "10 Minute Version" isn't a label this schema can derive for any
// other song, and labelling vault tracks generally was explicitly
// deferred by the user as "unnecessary for now" (see TASKS.md backlog).
function recording_display_title(string $songTitle, string $versionType): string
{
    if ($songTitle === 'All Too Well' && $versionType === 'other') {
        return "All Too Well (10 Minute Version) (Taylor's Version) [From the Vault]";
    }
    if ($versionType === 'original') {
        return $songTitle;
    }
    return $songTitle . ' (' . ucwords(format_version_type($versionType)) . ')';
}

// A hex accent colour per era, derived from the same official
// coloured-heart emoji already verified in sql/eras_seed.sql (fan/
// Taylor-Nation convention, not guessed) — used to give each era
// card on the homepage its own identity instead of one flat accent
// everywhere. Falls back to the site's default accent for any era
// not listed (e.g. if a future era is added before this is updated).
function era_accent_color(string $eraName): string
{
    return match ($eraName) {
        'Taylor Swift' => '#3a9456',
        'Fearless' => '#c9a227',
        'Speak Now' => '#7c4dbf',
        'Red' => '#b3263f',
        '1989' => '#3fa9d6',
        'reputation' => '#55555c',
        'Lover' => '#e8699e',
        'folklore' => '#8c8c93',
        'evermore' => '#8b5e3c',
        'Midnights' => '#33407a',
        'The Tortured Poets Department' => '#9a958f',
        'The Life of a Showgirl' => '#e2502f',
        default => '#9c1f3f',
    };
}

// Star toggle button for favouriting a song. Purely client-side —
// favorites.js reads/writes this in localStorage, nothing is sent
// to the server. Starts unfavourited; favorites.js corrects that on
// page load if the song is already saved.
function favourite_toggle_html(int $songId, string $title): string
{
    $safeTitle = htmlspecialchars($title, ENT_QUOTES);
    return '<button type="button" class="favourite-toggle" data-song-id="' . $songId . '"'
        . ' data-song-title="' . $safeTitle . '" aria-pressed="false"'
        . ' aria-label="Add ' . $safeTitle . ' to favourites">&#9734;</button>';
}

// --- User-submitted theme tagging helpers ---

// Lowercase, trim, collapse internal whitespace. Used so "Heartbreak"
// and "  heartbreak  " compare as the same word without affecting the
// case the DB's existing utf8mb4_0900_ai_ci collation already ignores.
function theme_name_normalize(string $name): string
{
    return trim(preg_replace('/\s+/', ' ', mb_strtolower($name)));
}

// Strips everything but letters/digits, so "Heart Break" and
// "heartbreak" compare identically — catches the exact-same-concept-
// different-spacing case without needing a fuzzy match for it.
function theme_name_squash(string $normalized): string
{
    return preg_replace('/[^a-z0-9]/', '', $normalized);
}

// Whole-word match only (plus a squashed-string check for simple
// spaced-out evasion like "r a p e") — never a substring scan, so a
// blocked word appearing inside an unrelated word (e.g. "rape" inside
// "grape") never triggers a false positive.
function theme_name_contains_blocked_word(string $name): bool
{
    static $blocklist = null;
    if ($blocklist === null) {
        $blocklist = require __DIR__ . '/profanity_blocklist.php';
    }

    $tokens = preg_split('/[^a-z0-9]+/', mb_strtolower($name), -1, PREG_SPLIT_NO_EMPTY);
    foreach ($tokens as $token) {
        if (in_array($token, $blocklist, true)) {
            return true;
        }
    }
    return in_array(implode('', $tokens), $blocklist, true);
}

// Looks for an existing theme that's either the exact same concept
// written differently (squashed match — auto-reuse, no need to ask)
// or close enough it's probably a typo (Levenshtein, within a
// length-scaled threshold — worth confirming with the user before
// creating a near-duplicate like "hartbreak" alongside "heartbreak").
// Returns null if the candidate name looks genuinely new.
function find_similar_theme(PDO $pdo, string $candidateName): ?array
{
    $normalizedCandidate = theme_name_normalize($candidateName);
    $squashedCandidate = theme_name_squash($normalizedCandidate);

    $existingThemes = $pdo->query('SELECT theme_id, name FROM themes')->fetchAll(PDO::FETCH_ASSOC);

    foreach ($existingThemes as $theme) {
        $normalizedExisting = theme_name_normalize($theme['name']);
        if (theme_name_squash($normalizedExisting) === $squashedCandidate) {
            return ['theme_id' => (int) $theme['theme_id'], 'name' => $theme['name'], 'certain' => true];
        }
    }

    foreach ($existingThemes as $theme) {
        $normalizedExisting = theme_name_normalize($theme['name']);
        $shorterLength = min(strlen($normalizedCandidate), strlen($normalizedExisting));
        $threshold = max(1, (int) floor($shorterLength / 4));
        if (levenshtein($normalizedCandidate, $normalizedExisting) <= $threshold) {
            return ['theme_id' => (int) $theme['theme_id'], 'name' => $theme['name'], 'certain' => false];
        }
    }

    return null;
}
