<?php
require __DIR__ . '/auth.php';
$pageTitle = 'Favourites — Taylor Swift Catalogue';
$currentNav = 'favourites';
$currentUser = current_user();
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Favourites</h1>
        <p class="muted">
            Click the <span aria-hidden="true">&#9734;</span> next to any
            song to add it here.
            <?php if ($currentUser): ?>
            You're logged in, so these are saved to your account and
            will follow you to any device you log into.
            <?php else: ?>
            These are stored only in this browser — not sent anywhere,
            not tied to an account — so they won't follow you to a
            different device or browser.
            <a href="login.php">Log in</a> to save them to your account
            instead.
            <?php endif; ?>
        </p>

        <noscript>
            <p class="muted">Favourites need JavaScript enabled to work, since they're stored in your browser rather than on the server.</p>
        </noscript>

        <p id="favourites-empty" class="muted" hidden>
            No favourites yet. Find a song you like on the
            <a href="search.php">Search</a> or <a href="moods.php">Moods</a>
            page and click its star.
        </p>
        <ul id="favourites-list" class="plain-list"></ul>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <?php include __DIR__ . '/scripts.php'; ?>
</body>
</html>
