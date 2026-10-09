<?php
// Expects an optional $currentNav variable to be set before include,
// one of: 'home', 'search', 'compare', 'compare_albums', 'moods',
// 'stats', 'favourites', 'tournament', 'playlists'.
// Used only to mark the current page for assistive tech
// (aria-current) — never trust it as input, it's always set by the
// including page itself, not the user.
$currentNav ??= null;
?>
<a class="skip-link" href="#main">Skip to content</a>
<header class="site-header">
    <div class="site-header-inner">
        <a class="site-title" href="index.php">Taylor Swift Catalogue</a>
        <nav class="site-nav" aria-label="Primary">
            <ul>
                <li><a href="index.php" <?= $currentNav === 'home' ? 'aria-current="page"' : '' ?>>Home</a></li>
                <li><a href="search.php" <?= $currentNav === 'search' ? 'aria-current="page"' : '' ?>>Search</a></li>
                <li><a href="compare.php" <?= $currentNav === 'compare' ? 'aria-current="page"' : '' ?>>Compare Songs</a></li>
                <li><a href="compare_albums.php" <?= $currentNav === 'compare_albums' ? 'aria-current="page"' : '' ?>>Compare Albums</a></li>
                <li><a href="moods.php" <?= $currentNav === 'moods' ? 'aria-current="page"' : '' ?>>Moods</a></li>
                <li><a href="stats.php" <?= $currentNav === 'stats' ? 'aria-current="page"' : '' ?>>Stats</a></li>
                <li><a href="favourites.php" <?= $currentNav === 'favourites' ? 'aria-current="page"' : '' ?>>Favourites</a></li>
                <li><a href="tournament.php" <?= $currentNav === 'tournament' ? 'aria-current="page"' : '' ?>>Tournament</a></li>
                <li><a href="playlists.php" <?= $currentNav === 'playlists' ? 'aria-current="page"' : '' ?>>My Playlists</a></li>
            </ul>
        </nav>
    </div>
</header>
