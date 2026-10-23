<?php
require __DIR__ . '/auth.php';
$pageTitle = 'Data Sources — Taylor Swift Catalogue';
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
        <h1>Data sources</h1>
        <p class="muted">Where the information in this catalogue actually comes from, and how reliable each part is.</p>

        <h2>Catalogue data</h2>
        <p>
            Albums, songs, recordings, track listings, songwriting and
            production credits, and track durations were sourced from
            Wikipedia, cross-checked against each album's published
            total runtime where one was available.
        </p>

        <h2>Album artwork</h2>
        <p>
            Cover art is fetched from the
            <a href="https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/">iTunes Search API</a>,
            matched to the exact album title and artist, and cached
            after the first lookup. See
            <a href="credits.php">Image Credits</a> for licensing
            details.
        </p>

        <h2>Music videos</h2>
        <p>
            Music video links were verified one at a time against
            Taylor Swift's official <code>@TaylorSwift</code> YouTube
            channel using YouTube's oEmbed endpoint — a video is only
            linked here if it's an official upload from that channel,
            not a fan re-upload or lyric video.
        </p>

        <h2>Themes &amp; moods</h2>
        <p>
            <strong>This is the one part of the catalogue that isn't
            sourced from anywhere.</strong> Unlike every other fact in
            this database, song themes and moods (used to power the
            <a href="moods.php">Moods</a> page) are the site author's
            own reading of each song's lyrical content — there's no
            Wikipedia infobox or liner notes to verify them against.
            Treat them as a considered first draft, not ground truth,
            especially for the most recently released songs.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
