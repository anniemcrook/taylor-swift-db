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
