<?php
// Expects an optional $currentNav variable to be set before include,
// one of: 'home', 'search', 'compare'. Used only to mark the current
// page for assistive tech (aria-current) — never trust it as input,
// it's always set by the including page itself, not the user.
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
                <li><a href="compare.php" <?= $currentNav === 'compare' ? 'aria-current="page"' : '' ?>>Compare Versions</a></li>
            </ul>
        </nav>
    </div>
</header>
