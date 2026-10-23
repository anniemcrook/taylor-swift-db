<?php
require __DIR__ . '/auth.php';
$pageTitle = 'Image Credits — Taylor Swift Catalogue';
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
        <h1>Image credits &amp; licences</h1>

        <p>
            Every cover image on this site is album artwork, fetched
            from the <a href="https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/">iTunes Search API</a>
            (operated by Apple) at <code>artworkUrl100</code>/
            <code>artworkUrl600</code>, matched by album title and
            artist. No other images — no artist photos, no custom
            illustrations, nothing from Wikimedia Commons or
            elsewhere — appear anywhere on the site.
        </p>

        <h2>Who owns this artwork</h2>
        <p>
            Album cover art is copyrighted by Taylor Swift and/or her
            label, Republic Records — as of 2025 she owns the masters
            and artwork for her entire catalogue, including the
            original albums through <em>reputation</em> that were once
            held by Big Machine Records. It is <strong>not</strong>
            under an open or reusable licence — it's used here solely
            to visually identify each album on an unofficial,
            non-commercial fan catalogue, the same way a music store
            or streaming app would display it for identification.
        </p>

        <p class="muted">
            This isn't a claim that the artwork is freely reusable —
            it's a record of exactly where each image comes from and
            why it's here. If this project is ever deployed publicly
            or for any commercial purpose, this usage should be
            revisited against each label's actual terms rather than
            relied on as-is.
        </p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
