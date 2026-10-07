<?php
$pageTitle = 'Privacy — Taylor Swift Catalogue';
$currentNav = null;
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Privacy</h1>

        <p>This is a short page because there isn't much to say.</p>

        <ul>
            <li>No accounts, logins, or sign-ups anywhere on this site.</li>
            <li>No analytics, tracking scripts, or third-party trackers of any kind.</li>
            <li>No cookies are set.</li>
            <li>
                <a href="favourites.php">Favourites</a> are saved using
                your browser's local storage, not a cookie — the list
                of songs you've starred lives only on this device, in
                this browser. It's never sent to a server, never
                shared, and clearing your browser data removes it.
            </li>
            <li>
                The only outside requests this site makes are
                server-side, to fetch album artwork and verify music
                video links (see <a href="data_sources.php">Data
                Sources</a>) — nothing about you as a visitor is sent
                anywhere.
            </li>
        </ul>

        <p class="muted">
            If more personalisation features (ratings, rankings, that
            kind of thing) are added later, they'll work the same way
            — saved locally in your browser, nothing sent to a server.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
