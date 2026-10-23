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
                If you're logged in, your Favourites and Playlists are
                saved to your account instead of just this browser, so
                they follow you to any device you log into. The
                in-progress <a href="tournament.php">Tournament</a>
                bracket itself (which matchup you're on, your undo
                history) always stays local to the browser you're
                playing in, logged in or not — only the finished result
                is saved to your account. The first time you log in
                with existing Favourites/Playlists/a finished Tournament
                result already in a browser, that local data is copied
                to your account once; after that, your account is what's
                shown, on every device, and local-only data on any
                device is left alone.
            </li>
            <li>
                If you're logged in, you can tag a song with a theme
                (an existing one, or a new one you suggest) on that
                song's page. This is sent to and stored on the server —
                your account's <code>user_id</code>, the song, and the
                theme — so it can be shown to other visitors as a
                community tag. It isn't anonymous: it's tied to your
                account the same way a forum post would be. A theme
                name you suggest is checked against a blocklist of
                disallowed words and against existing theme names
                (to avoid near-duplicates like "heartbreak" and
                "hartbreak" both existing) before it's created.
            </li>
            <li>
                When you're logged out: <a href="favourites.php">Favourites</a>
                are saved using your browser's local storage, not a
                cookie — the list of songs you've starred lives only
                on this device, in this browser. It's never sent to a
                server, never shared, and clearing your browser data
                removes it. (See above for what changes once you log in.)
            </li>
            <li>
                When you're logged out: the <a href="tournament.php">Favourite
                Song Tournament</a> works the same way — your progress
                through the bracket is saved locally so you can close
                the tab and come back, but it never leaves this
                browser either. This part is actually true logged in
                or out — only the finished result, not the in-progress
                bracket, is ever saved to your account.
            </li>
            <li>
                When you're logged out: <a href="playlists.php">Playlists</a>
                (including any built from your Tournament results) are
                saved the same way too — this browser only, nothing
                sent anywhere. (See above for what changes once you
                log in.)
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
            If this site ever shows aggregate stats pulled from
            everyone's Tournament results, that'll also genuinely
            involve sending something to the server — this page will
            be updated to say so plainly rather than quietly becoming
            inaccurate.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
