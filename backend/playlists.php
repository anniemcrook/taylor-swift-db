<?php
require __DIR__ . '/auth.php';
$pageTitle = 'My Playlists — Taylor Swift Catalogue';
$currentNav = 'playlists';
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
        <h1>My Playlists</h1>
        <p class="muted">
            <?php if ($currentUser): ?>
            You're logged in, so these are saved to your account and
            will follow you to any device you log into.
            <?php else: ?>
            Saved in this browser only — not sent anywhere, not tied
            to an account, so they won't follow you to a different
            device. <a href="login.php">Log in</a> to save them to
            your account instead.
            <?php endif; ?>
            Build one from your <a href="tournament.php">Tournament</a>
            results.
        </p>

        <noscript>
            <p class="muted">Playlists need JavaScript enabled to work, since they're stored in your browser rather than on the server.</p>
        </noscript>

        <p id="playlists-empty" class="muted" hidden>
            No playlists yet. Finish a <a href="tournament.php">Tournament</a>
            run and save your results as a playlist.
        </p>
        <p id="playlists-status" class="visually-hidden" role="status" aria-live="polite"></p>
        <div id="playlists-root"></div>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <script src="playlists.js" defer></script>
    <script src="playlists_view.js" defer></script>
</body>
</html>
