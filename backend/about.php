<?php
$pageTitle = 'About — Taylor Swift Catalogue';
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
        <h1>About this project</h1>

        <p>
            This is an unofficial, fan-made catalogue of Taylor Swift's
            discography — every album, song, recording (original vs.
            Taylor's Version vs. other alternate takes), songwriting and
            production credit, and official music video, searchable and
            browsable in a few different ways: by album, by song, side
            by side comparisons of songs or whole albums, and by theme
            or mood.
        </p>

        <p>
            It isn't affiliated with, endorsed by, or connected to
            Taylor Swift, Taylor Nation, or any record label — see the
            <a href="data_sources.php">Data Sources</a> page for where
            the information actually comes from.
        </p>

        <h2>Why it exists</h2>
        <p>
            This project was built as a personal software-development
            portfolio piece: a chance to design a real relational
            schema from scratch (one song can have multiple
            recordings; one recording can belong to multiple album
            editions), populate it with a genuinely large, structured
            real-world dataset, and build a small set of features on
            top of it — search, comparison tools, and a free-form
            theme/mood tagging system — using plain, readable code
            rather than a framework doing the work invisibly.
        </p>

        <h2>How it's built</h2>
        <ul>
            <li>PHP (with PDO and prepared statements throughout), no framework</li>
            <li>MySQL for storage — see the schema in <code>sql/schema.sql</code></li>
            <li>Album artwork from the iTunes Search API</li>
            <li>Music video links verified against Taylor Swift's official YouTube channel</li>
            <li>Plain HTML/CSS, no client-side JavaScript</li>
        </ul>

        <p class="muted">
            The source code is public on
            <a href="https://github.com/anniemcrook/taylor-swift-db">GitHub</a>.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
