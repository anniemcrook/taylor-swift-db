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
