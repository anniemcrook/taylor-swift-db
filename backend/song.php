<?php
// --- Database connection ---
require __DIR__ . '/config.php';
require __DIR__ . '/auth.php';
require __DIR__ . '/helpers.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$songId = isset($_GET['song_id']) ? (int) $_GET['song_id'] : 0;

if ($songId === 0) {
    die("Please provide a song, e.g. song.php?song_id=1");
}

$songStmt = $pdo->prepare("SELECT title FROM songs WHERE song_id = :id");
$songStmt->execute(['id' => $songId]);
$song = $songStmt->fetch(PDO::FETCH_ASSOC);

if (!$song) {
    die("No song found with that ID.");
}

// --- Handle a theme-tagging/suggestion submission, if any ---
$currentUser = current_user();
$tagErrors = [];
$tagNotice = null;
$pendingConfirmation = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['theme_action'])) {
    if (!$currentUser) {
        $tagErrors[] = 'You need to be logged in to tag this song.';
    } elseif (!verify_csrf_token($_POST['csrf_token'] ?? null)) {
        $tagErrors[] = 'Your session expired — please try again.';
    } else {
        $action = $_POST['theme_action'];

        $applyThemeToSong = function (int $themeId) use ($pdo, $currentUser, $songId, &$tagNotice, &$tagErrors): void {
            try {
                $stmt = $pdo->prepare('INSERT INTO user_song_themes (user_id, song_id, theme_id) VALUES (:userId, :songId, :themeId)');
                $stmt->execute(['userId' => $currentUser['user_id'], 'songId' => $songId, 'themeId' => $themeId]);
                $tagNotice = 'Tag added — thanks!';
            } catch (PDOException $e) {
                if ($e->getCode() === '23000') {
                    $tagNotice = "You've already tagged this song with that theme.";
                } else {
                    throw $e;
                }
            }
        };

        if ($action === 'apply_existing') {
            $themeId = (int) ($_POST['theme_id'] ?? 0);
            $checkStmt = $pdo->prepare('SELECT theme_id FROM themes WHERE theme_id = :id');
            $checkStmt->execute(['id' => $themeId]);
            if (!$checkStmt->fetch()) {
                $tagErrors[] = 'Pick a theme from the list.';
            } else {
                $applyThemeToSong($themeId);
            }
        } elseif ($action === 'suggest_new') {
            $newName = trim((string) ($_POST['new_theme_name'] ?? ''));
            $confirmNew = isset($_POST['confirm_new_theme']);
            $useExistingThemeId = isset($_POST['use_existing_theme_id']) ? (int) $_POST['use_existing_theme_id'] : null;

            if ($useExistingThemeId) {
                $applyThemeToSong($useExistingThemeId);
            } elseif ($newName === '') {
                $tagErrors[] = 'Enter a theme name.';
            } elseif (strlen($newName) > 100) {
                $tagErrors[] = 'Theme name must be 100 characters or fewer.';
            } elseif (theme_name_contains_blocked_word($newName)) {
                $tagErrors[] = "That theme name isn't allowed — try different wording.";
            } else {
                $similar = find_similar_theme($pdo, $newName);
                if ($similar && $similar['certain']) {
                    // Same concept, just written differently (case,
                    // spacing, punctuation) — reuse automatically
                    // rather than asking, since there's no real
                    // ambiguity to confirm.
                    $applyThemeToSong($similar['theme_id']);
                } elseif ($similar && !$confirmNew) {
                    // Close enough it's probably a typo of an
                    // existing theme — ask before creating a
                    // near-duplicate like "hartbreak" next to
                    // "heartbreak".
                    $pendingConfirmation = [
                        'name' => $newName,
                        'existing_name' => $similar['name'],
                        'existing_theme_id' => $similar['theme_id'],
                    ];
                } else {
                    try {
                        $pdo->beginTransaction();
                        $insertThemeStmt = $pdo->prepare('INSERT INTO themes (name) VALUES (:name)');
                        $insertThemeStmt->execute(['name' => $newName]);
                        $newThemeId = (int) $pdo->lastInsertId();
                        $insertTagStmt = $pdo->prepare('INSERT INTO user_song_themes (user_id, song_id, theme_id) VALUES (:userId, :songId, :themeId)');
                        $insertTagStmt->execute(['userId' => $currentUser['user_id'], 'songId' => $songId, 'themeId' => $newThemeId]);
                        $pdo->commit();
                        $tagNotice = 'New theme "' . $newName . '" suggested and added — thanks!';
                    } catch (PDOException $e) {
                        $pdo->rollBack();
                        if ($e->getCode() === '23000') {
                            $tagErrors[] = 'That theme already exists — try searching for it in the list above.';
                        } else {
                            throw $e;
                        }
                    }
                }
            }
        }
    }
}

$communityTagsStmt = $pdo->prepare("
    SELECT t.theme_id, t.name, COUNT(DISTINCT ust.user_id) AS vote_count
    FROM user_song_themes ust
    JOIN themes t ON t.theme_id = ust.theme_id
    WHERE ust.song_id = :songId
    GROUP BY t.theme_id, t.name
    ORDER BY vote_count DESC, t.name
");
$communityTagsStmt->execute(['songId' => $songId]);
$communityTags = $communityTagsStmt->fetchAll(PDO::FETCH_ASSOC);

$allThemesForTagging = $pdo->query('SELECT theme_id, name FROM themes ORDER BY name')->fetchAll(PDO::FETCH_ASSOC);

// --- Every recording of this song, with credits and music video ---
$recordingStmt = $pdo->prepare("
    SELECT r.recording_id, r.version_type, r.duration_seconds, r.music_video_url,
           al.album_id, al.title AS album_title, at.track_number
    FROM recordings r
    LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
    LEFT JOIN albums al ON al.album_id = at.album_id
    WHERE r.song_id = :songId
    ORDER BY al.release_date, at.track_number
");
$recordingStmt->execute(['songId' => $songId]);
$recordings = $recordingStmt->fetchAll(PDO::FETCH_ASSOC);

$creditStmt = $pdo->prepare("
    (SELECT ar.name FROM recording_songwriters rs
        JOIN artists ar ON ar.artist_id = rs.artist_id
        WHERE rs.recording_id = :recId1)
    UNION
    (SELECT ar.name FROM recording_producers rp
        JOIN artists ar ON ar.artist_id = rp.artist_id
        WHERE rp.recording_id = :recId2)
    ORDER BY name
");
foreach ($recordings as &$recording) {
    $creditStmt->execute([
        'recId1' => $recording['recording_id'],
        'recId2' => $recording['recording_id'],
    ]);
    $recording['credits'] = $creditStmt->fetchAll(PDO::FETCH_COLUMN);
}
unset($recording);

// --- Themes tagged on any recording of this song ---
$themeStmt = $pdo->prepare("
    SELECT DISTINCT t.name
    FROM recording_themes rt
    JOIN themes t ON t.theme_id = rt.theme_id
    JOIN recordings r ON r.recording_id = rt.recording_id
    WHERE r.song_id = :songId
    ORDER BY t.name
");
$themeStmt->execute(['songId' => $songId]);
$themes = $themeStmt->fetchAll(PDO::FETCH_COLUMN);

// --- Similar songs: others sharing at least one theme, ranked by how
// many they share. Matches at the song level (any recording of this
// song vs. any recording of the other), same approach as the Moods
// playlist, so an original/Taylor's Version pair isn't double-counted.
$similarStmt = $pdo->prepare("
    SELECT s2.song_id, s2.title, COUNT(DISTINCT rt2.theme_id) AS shared_count
    FROM recording_themes rt1
    JOIN recordings r1 ON r1.recording_id = rt1.recording_id
    JOIN recording_themes rt2 ON rt2.theme_id = rt1.theme_id
    JOIN recordings r2 ON r2.recording_id = rt2.recording_id
    JOIN songs s2 ON s2.song_id = r2.song_id
    WHERE r1.song_id = :songId1
      AND s2.song_id != :songId2
    GROUP BY s2.song_id, s2.title
    ORDER BY shared_count DESC, s2.title
    LIMIT 8
");
$similarStmt->execute(['songId1' => $songId, 'songId2' => $songId]);
$similarSongs = $similarStmt->fetchAll(PDO::FETCH_ASSOC);

// For each similar song: which specific themes it shares (the "why"),
// plus a representative recording (preferring the original) for the
// album/duration shown.
$sharedThemesStmt = $pdo->prepare("
    SELECT DISTINCT t.name
    FROM recording_themes rt1
    JOIN recordings r1 ON r1.recording_id = rt1.recording_id
    JOIN themes t ON t.theme_id = rt1.theme_id
    WHERE r1.song_id = :songId
      AND rt1.theme_id IN (
          SELECT rt2.theme_id FROM recording_themes rt2
          JOIN recordings r2 ON r2.recording_id = rt2.recording_id
          WHERE r2.song_id = :otherSongId
      )
    ORDER BY t.name
");
$representativeStmt = $pdo->prepare("
    SELECT al.album_id, al.title AS album_title, r.duration_seconds
    FROM recordings r
    LEFT JOIN album_tracks at ON at.recording_id = r.recording_id
    LEFT JOIN albums al ON al.album_id = at.album_id
    WHERE r.song_id = :songId
    ORDER BY (r.version_type = 'original') DESC, al.release_date, at.track_number
    LIMIT 1
");
foreach ($similarSongs as &$similar) {
    $sharedThemesStmt->execute(['songId' => $songId, 'otherSongId' => $similar['song_id']]);
    $similar['shared_themes'] = $sharedThemesStmt->fetchAll(PDO::FETCH_COLUMN);

    $representativeStmt->execute(['songId' => $similar['song_id']]);
    $similar['representative'] = $representativeStmt->fetch(PDO::FETCH_ASSOC);
}
unset($similar);

$recordingCount = count($recordings);

$pageTitle = $song['title'] . ' — Taylor Swift Catalogue';
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
        <h1><?= htmlspecialchars($song['title']) ?> <?= favourite_toggle_html($songId, $song['title']) ?></h1>

        <?php if ($themes !== []): ?>
        <p class="tag muted">Themes: <?= htmlspecialchars(implode(', ', $themes)) ?></p>
        <?php endif; ?>

        <?php if ($communityTags !== []): ?>
        <p class="tag muted">Community tags:
            <?php foreach ($communityTags as $i => $communityTag): ?>
                <?= $i > 0 ? ', ' : '' ?><?= htmlspecialchars($communityTag['name']) ?> (<?= (int) $communityTag['vote_count'] ?>)
            <?php endforeach; ?>
        </p>
        <?php endif; ?>

        <section class="theme-tagging">
            <h2>Tag this song</h2>

            <?php if ($tagNotice): ?>
            <p class="form-notice"><?= htmlspecialchars($tagNotice) ?></p>
            <?php endif; ?>

            <?php if ($tagErrors !== []): ?>
            <div class="form-errors">
                <ul>
                    <?php foreach ($tagErrors as $error): ?>
                    <li><?= htmlspecialchars($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endif; ?>

            <?php if (!$currentUser): ?>
            <p class="muted"><a href="login.php">Log in</a> to tag this song or suggest a new theme.</p>
            <?php elseif ($pendingConfirmation): ?>
            <form method="post" action="song.php?song_id=<?= (int) $songId ?>" class="auth-form">
                <?= csrf_field() ?>
                <input type="hidden" name="theme_action" value="suggest_new">
                <input type="hidden" name="new_theme_name" value="<?= htmlspecialchars($pendingConfirmation['name']) ?>">
                <p>Did you mean the existing theme "<strong><?= htmlspecialchars($pendingConfirmation['existing_name']) ?></strong>"?</p>
                <button type="submit" name="use_existing_theme_id" value="<?= (int) $pendingConfirmation['existing_theme_id'] ?>">Yes, use that</button>
                <button type="submit" name="confirm_new_theme" value="1">No, mine is different</button>
            </form>
            <?php else: ?>
            <form method="post" action="song.php?song_id=<?= (int) $songId ?>" class="auth-form">
                <?= csrf_field() ?>
                <input type="hidden" name="theme_action" value="apply_existing">
                <label for="theme_id">Apply an existing theme
                    <select id="theme_id" name="theme_id">
                        <?php foreach ($allThemesForTagging as $theme): ?>
                        <option value="<?= (int) $theme['theme_id'] ?>"><?= htmlspecialchars($theme['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </label>
                <button type="submit">Add tag</button>
            </form>
            <form method="post" action="song.php?song_id=<?= (int) $songId ?>" class="auth-form">
                <?= csrf_field() ?>
                <input type="hidden" name="theme_action" value="suggest_new">
                <label for="new_theme_name">Or suggest a new theme
                    <input type="text" id="new_theme_name" name="new_theme_name" maxlength="100">
                </label>
                <button type="submit">Suggest</button>
            </form>
            <?php endif; ?>
        </section>

        <?php if ($recordingCount > 1): ?>
        <p class="muted"><a href="compare.php?song_id=<?= (int) $songId ?>">Compare all <?= $recordingCount ?> versions side by side</a></p>
        <?php endif; ?>

        <h2>Recordings</h2>
        <div class="table-wrap">
            <table>
                <caption class="visually-hidden"><?= htmlspecialchars($song['title']) ?> recordings</caption>
                <tr>
                    <th scope="col">Version</th>
                    <th scope="col">Album</th>
                    <th scope="col">Track #</th>
                    <th scope="col">Duration</th>
                    <th scope="col">Credits</th>
                    <th scope="col">Music Video</th>
                </tr>
                <?php foreach ($recordings as $recording): ?>
                <tr>
                    <td><?= htmlspecialchars(format_version_type($recording['version_type'])) ?></td>
                    <td>
                        <?php if ($recording['album_id']): ?>
                        <a href="tracklist.php?album_id=<?= (int) $recording['album_id'] ?>">
                            <?= htmlspecialchars($recording['album_title']) ?>
                        </a>
                        <?php else: ?>
                        —
                        <?php endif; ?>
                    </td>
                    <td><?= htmlspecialchars($recording['track_number'] ?? '—') ?></td>
                    <td><?= $recording['duration_seconds'] ? gmdate('i:s', $recording['duration_seconds']) : '—' ?></td>
                    <td><?= htmlspecialchars(implode(', ', $recording['credits'])) ?></td>
                    <td>
                        <?php if ($recording['music_video_url']): ?>
                        <a href="<?= htmlspecialchars($recording['music_video_url']) ?>" target="_blank" rel="noopener">
                            Watch<span class="visually-hidden"> (opens in a new tab)</span>
                        </a>
                        <?php else: ?>
                        —
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>

        <h2>Similar songs</h2>
        <?php if ($themes === []): ?>
        <p class="muted">This song isn't tagged with any themes yet, so there's nothing to base similarity on.</p>
        <?php elseif ($similarSongs === []): ?>
        <p class="muted">No other songs currently share a theme with this one.</p>
        <?php else: ?>
        <ul class="plain-list">
            <?php foreach ($similarSongs as $similar): ?>
            <?php $rep = $similar['representative']; ?>
            <li>
                <a href="song.php?song_id=<?= (int) $similar['song_id'] ?>"><strong><?= htmlspecialchars($similar['title']) ?></strong></a>
                <?php if ($rep && $rep['album_title']): ?>
                — <a href="tracklist.php?album_id=<?= (int) $rep['album_id'] ?>"><?= htmlspecialchars($rep['album_title']) ?></a>
                <?php endif; ?>
                <?php if ($rep && $rep['duration_seconds']): ?>
                · <?= gmdate('i:s', $rep['duration_seconds']) ?>
                <?php endif; ?>
                <br>
                <span class="tag muted">Shares: <?= htmlspecialchars(implode(', ', $similar['shared_themes'])) ?></span>
            </li>
            <?php endforeach; ?>
        </ul>
        <?php endif; ?>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
    <?php include __DIR__ . '/scripts.php'; ?>
</body>
</html>
