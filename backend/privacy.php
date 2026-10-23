<?php
require __DIR__ . '/auth.php';
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

        <p>
            Creating an account is entirely optional — everything on this
            site works without one. This page covers both cases.
        </p>

        <ul>
            <li>No analytics, tracking scripts, or third-party trackers of any kind.</li>
            <li>
                If you don't <a href="register.php">register</a> or
                <a href="login.php">log in</a>, no cookie is set and no
                account exists for you — the rest of this list applies.
            </li>
            <li>
                If you do register or log in, this site stores your
                email, a securely hashed password (never the password
                itself — it's run through PHP's <code>password_hash()</code>,
                the same one-way hashing approach used everywhere this
                kind of thing is done properly), and the display name you
                chose. Logging in sets one cookie, used only to remember
                that you're logged in on this device — not for tracking,
                analytics, or anything shared with anyone else.
            </li>
            <li>
                An account doesn't currently do anything with your
                Favourites, Tournament progress, or Playlists — those
                three still work exactly as described below, entirely in
                your browser, whether or not you're logged in. Syncing
                them to your account is a possible future feature, not
                something this site does yet.
            </li>
            <li>
                <a href="favourites.php">Favourites</a> are saved using
                your browser's local storage, not a cookie — the list
                of songs you've starred lives only on this device, in
                this browser. It's never sent to a server, never
                shared, and clearing your browser data removes it.
            </li>
            <li>
                The <a href="tournament.php">Favourite Song
                Tournament</a> works the same way — your progress
                through the bracket is saved locally so you can close
                the tab and come back, but it never leaves this
                browser either.
            </li>
            <li>
                <a href="playlists.php">Playlists</a> (including any
                built from your Tournament results) are saved the
                same way too — this browser only, nothing sent
                anywhere.
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
            If this site ever lets logged-in users vote on song themes,
            or shows aggregate stats pulled from everyone's Tournament
            results, that'll genuinely involve sending something to the
            server — this page will be updated to say so plainly rather
            than quietly becoming inaccurate.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
