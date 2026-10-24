# Project Tasks

Running log of what's done and what's left on the Taylor Swift DB project.
Check this at the start of every session before starting new work.

## Deferred until going public

Not urgent for now — this is a personal/local project. Revisit these
before the repo or app is ever made public or deployed anywhere:

- [ ] Rotate the MySQL `root` password that was briefly hardcoded in
      `backend/tracklist.php` and `backend/index.php` during early
      development. It was never committed to git, but was live on
      disk — rotate it as a precaution before treating it as safe.
      **Genuinely more urgent as of 2026-10-23**: the `users` table
      now holds real emails and password hashes, so this database
      isn't purely disposable catalogue data anymore. Not acted on
      without being asked, just flagged here honestly rather than
      left at the same priority it had before accounts existed.
- [ ] Decide on a real (non-root) MySQL user with limited privileges
      for the app to connect as, instead of `root`. Same note as
      above — this one's priority went up today too, for the same
      reason.

## Completed

- [x] Design schema separating songs / recordings / albums /
      album_tracks + songwriter/producer credit junction tables, to
      support one song having multiple recordings (e.g. original vs
      Taylor's Version).
- [x] Populate data for *1989* and *1989 (Taylor's Version)* — all 21
      tracks, credits, durations.
- [x] Build `backend/tracklist.php` — takes `album_id` from the URL,
      renders that album's tracklist (PDO, prepared statements).
- [x] Build `backend/index.php` — homepage listing all albums as
      links to their tracklist pages.
- [x] Move DB credentials out of tracked PHP files into
      `backend/config.php` (gitignored) with `backend/config.example.php`
      as a template for setup on a new machine.
- [x] Add *Taylor Swift* (2006 debut, standard edition, 11 tracks)
      with songwriter/producer credits and durations, sourced from
      Wikipedia and verified against the album's total runtime.
      Seed data lives in `sql/2006_taylor_swift_debut.sql`.
- [x] Add an `edition` column to `album_tracks` (nullable; e.g.
      'Platinum Edition', 'From the Vault', 'Bonus Track') so bonus
      tracks can be tagged without needing a separate album row per
      edition. Migration: `sql/0001_add_album_tracks_edition.sql`.
- [x] Add *Fearless* (2008 standard + 2009 Platinum Edition bonus
      tracks, 19 tracks total) and *Fearless (Taylor's Version)*
      (2021, 26 tracks incl. the "Today Was a Fairytale" bonus and 6
      From the Vault tracks). Re-recorded songs reuse the same `songs`
      row as the original via title lookup. Durations verified against
      each album's official total runtime. Seed data:
      `sql/2008_fearless.sql`, `sql/2021_fearless_taylors_version.sql`.
- [x] Add *Speak Now* (2010 standard + Deluxe Edition, 20 tracks) and
      *Speak Now (Taylor's Version)* (2023, 22 tracks incl. 6 From the
      Vault tracks). The Deluxe Edition's acoustic ("Back to December",
      "Haunted") and pop-mix ("Mine") bonus tracks are modeled as
      additional `recordings` rows on the *same* song rather than new
      songs — a good example of the schema's song/recording split.
      Durations verified against each album's official total runtime.
      Seed data: `sql/2010_speak_now.sql`,
      `sql/2023_speak_now_taylors_version.sql`.
- [x] Add *Red* (2012 standard + Deluxe Edition, 22 tracks) and
      *Red (Taylor's Version)* (2021, 30 tracks incl. 9 new From the
      Vault songs plus the extended "All Too Well (10 Minute Version)",
      which reuses the existing "All Too Well" song as a new
      `recording` with `version_type = 'other'`). "State of Grace" now
      has 4 distinct recordings (2012 original, 2012 deluxe acoustic,
      2021 TV, 2021 TV acoustic) — the most-recorded song in the DB so
      far. Ran a data-integrity check after Fearless (dup titles,
      original/TV song_id matching, recording counts) and repeated the
      same checks here; both passed cleanly. Durations verified against
      each album's official total runtime. Seed data: `sql/2012_red.sql`,
      `sql/2021_red_taylors_version.sql`.
- [x] Add *reputation* (2017, 15 tracks) and *Lover* (2019, 18 tracks)
      — neither has a Taylor's Version yet, and neither had a bonus
      edition that added new songs, so both are single, simple album
      rows with no `edition` tags. Lover's duration matched its
      official 61:48 total exactly. reputation's Wikipedia infobox
      states 55:45, but that's off by 7 seconds from the sum of its own
      per-track lengths (55:38); the individual track lengths were
      independently confirmed against Apple Music and used as-is.
      Seed data: `sql/2017_reputation.sql`, `sql/2019_lover.sql`.
- [x] Add *folklore* (2020, 16 tracks + 1 deluxe bonus, "the lakes")
      and *evermore* (2020, 15 tracks + 2 deluxe bonus tracks). Neither
      has a Taylor's Version. **Data-quality catch:** the initial bulk
      Wikipedia fetch for evermore's tracklist had badly wrong lengths
      for 5 of its 15 tracks (e.g. "Cowboy like Me" as 3:56 instead of
      the real 4:35, "Closure" as 3:31 instead of 3:00) — caught only
      because the sum of those lengths (58:05) was 2m33s short of the
      album's stated 60:38 total, which is far too big a gap to be
      rounding. Every track was then re-verified individually, and the
      corrected lengths sum to 60:39 (1-second match). **Lesson: always
      sum durations and diff against the album's stated total before
      trusting a bulk-fetched tracklist — a small gap (a few seconds)
      is a rounding/infobox quirk (seen on reputation and folklore
      too), but a gap of tens of seconds or more means the data itself
      is wrong and needs per-track re-verification.** Seed data:
      `sql/2020_folklore.sql`, `sql/2020_evermore.sql`.

- [x] Add *Midnights* (2022) covering every officially released
      edition in one album row, tagged via `edition`: standard (13),
      '3am Edition' (+7), 'Til Dawn Edition' (+3: a new song "Hits
      Different", plus new extended/remix recordings of "Snow on the
      Beach" and "Karma" on their existing songs), and 'Late Night
      Edition' (+1: "You're Losing Me (From the Vault)") — 24 tracks
      total. Skipped the Lavender/Japan CD-exclusive remix-only bonus
      tracks (strings/piano remixes of existing songs) as out of scope
      for now. Verified in tiers: standard sums to exactly 44:02,
      standard+3am to exactly 69:20, and standard+3am+Til-Dawn-additions
      to 80:25 against Apple Music's independently-confirmed "~1h20m"
      (the initial bulk fetch's stated Til Dawn total of 81:26 was
      likely a minor infobox error, same pattern as reputation).
      Seed data: `sql/2022_midnights.sql`.

- [x] Add *The Tortured Poets Department* (2024) — standard edition
      (16 tracks) plus the simultaneously-released "The Anthology"
      bonus disc (+15, tagged edition='The Anthology'), 31 tracks
      total. No Taylor's Version. The bulk Wikipedia tracklist fetch
      failed outright this time (no usable table at all), so every
      track was looked up individually from the start. Standard
      edition sums to exactly 65:08, an exact match; the full 31-track
      total sums to 122:21, matching Apple Music's independently-
      confirmed "2 hours 2 minutes" for the complete Anthology edition.
      A few Anthology tracks' sources didn't explicitly restate Taylor
      as co-producer alongside Aaron Dessner — included her anyway
      since that pattern holds without exception on every other
      Dessner-produced track on the album. Seed data:
      `sql/2024_the_tortured_poets_department.sql`.

- [x] Add *The Life of a Showgirl* (2025), 12 tracks — Taylor's first
      album made with a single, uniform production team throughout
      (just Taylor, Max Martin, and Shellback; no other collaborators),
      so writer/producer credits are identical across every track
      except "Father Figure", which carries an added interpolation
      credit for George Michael. Durations sum to exactly 41:40, an
      exact match. Skipped the CD-exclusive variant editions' acoustic
      re-recordings and voice-memo versions of existing songs (not new
      songs, out of scope for now — same call as the Lavender/Japan
      remix-only bonus content skipped on Fearless and Midnights).
      Seed data: `sql/2025_the_life_of_a_showgirl.sql`.

This completes the full catalog through *The Life of a Showgirl*
(2025) — all 16 albums, every original/Taylor's Version pairing, and
every officially released deluxe/platinum/vault/anthology edition, are
now in the database.

- [x] Add *The Life of a Showgirl: The Encore* (2026-09-25) — 4 new
      bonus tracks ("Patient Zero", "Cleveland!", "Pink Clouding",
      "Babylon") added to the existing *The Life of a Showgirl* album
      row as tracks 13-16, tagged edition='The Encore'. Same writer/
      producer trio as the rest of the album (Taylor, Max Martin,
      Shellback). Durations verified: the 4 bonus tracks plus the
      original 12 sum to 55:41, matching Apple Music's independently-
      confirmed "~55 minutes" for the full 16-track Encore edition.
      Seed data: `sql/2026_the_life_of_a_showgirl_the_encore.sql`.
- [x] Built out the full page set: `backend/search.php` (search by
      song title OR songwriter/producer name, showing every album
      appearance per match with credits), `backend/compare.php`
      (list every song with 2+ recordings, then a side-by-side
      version-comparison table for one song — duration/album/track/
      credits per version), and `backend/nav.php` (shared nav
      included on every page: Home | Search | Compare Versions).
- [x] Added album artwork via the iTunes Search API
      (`backend/artwork.php`) — no API key needed, results cached into
      the existing (previously unused) `albums.cover_url` column so
      each album only ever hits the network once. Shown as a 60x60
      thumbnail per album on the homepage and a 300x300 image at the
      top of each tracklist page. Had to fix the matching logic once:
      iTunes' relevance ranking doesn't always put the exact album
      asked for first (a plain "Speak Now" query ranked "Speak Now
      (Taylor's Version)" above the original), so the helper now
      prefers an exact `collectionName` match before falling back to
      "first Taylor Swift result." All 16 albums' artwork URLs are
      pre-cached and verified to return HTTP 200.
      On the legality of using real album art: covered with the user
      directly (not written up here) — short version is small
      identification-only thumbnails fetched live via Apple's public
      iTunes Search API (rather than scraped/stored image files) was
      the agreed approach, closest to how Discogs/MusicBrainz-style
      sites handle it.
- [x] Fixed a gap the user caught: credits (songwriters/producers)
      were only visible via the compare page, so any song with just
      one recording had no way to see its credits at all. Added a
      Credits column directly to `backend/tracklist.php` so every
      track on every album shows its credits inline, with a
      "(compare versions)" link appearing next to the title only when
      that song actually has more than one recording.
- [x] Added a Music Video column. Schema: `recordings.music_video_url`
      (migration `sql/0002_add_recordings_music_video_url.sql`) — a
      video belongs to the specific recording it was filmed for. When
      a recording has no video of its own, `tracklist.php` borrows the
      video from another recording of the same song (preferring the
      'original') and labels it via `backend/helpers.php`'s
      `format_version_type()`, e.g. "(original version)". Deliberately
      scoped to real official music videos only — lyric videos and
      visualizers don't count, which matters: e.g. "Love Story
      (Taylor's Version)" only ever got a lyric video, never a new
      full music video, so its row correctly borrows and labels the
      2008 original's video instead of showing nothing. Verified every
      candidate YouTube URL via YouTube's oEmbed endpoint
      (`author_url`) before using it, specifically to confirm it's
      actually on Taylor's own channel (`@TaylorSwift`) rather than a
      label/fan/reaction channel reupload — the first search hit for
      "Love Story official video" was a channel called "PopMusicMTV",
      not her channel, so this check matters. Only "Love Story" /
      "Love Story (Taylor's Version)" are populated so far as a
      proof-of-concept.
- [x] Did the Fearless era as the agreed trial run: "Fearless",
      "White Horse", "You Belong with Me", "Fifteen", "The Best Day",
      and "Change" (all 6 originals), confirmed via oEmbed to really
      be on `@TaylorSwift` after multiple search-result false positives
      (e.g. a "White Horse" result from "countrymusicgirl16", a "You
      Belong with Me" one from "LegacyNationMusic"). "The Best Day
      (Taylor's Version)" got a genuine new official video (own URL,
      no borrow note); every other Fearless-era re-recording only ever
      got a lyric video (not counted), so those 5 correctly borrow and
      label the original's video via the existing logic. Seed data
      (idempotent `UPDATE`s, not a fresh migration):
      `sql/music_videos_fearless.sql`.
- [x] Rolled out music videos across the rest of the catalog: debut
      album (5 singles, `sql/music_videos_debut.sql`), Speak Now (6,
      `sql/music_videos_speak_now.sql`), Red (7 originals + the "All
      Too Well" short film + the vault track "I Bet You Think About
      Me", `sql/music_videos_red.sql`), 1989 (7, `sql/music_videos_1989.sql`),
      reputation (4, `sql/music_videos_reputation.sql`), Lover (4,
      `sql/music_videos_lover.sql`), folklore + evermore (1 each —
      "cardigan" and "willow", `sql/music_videos_folklore_evermore.sql`),
      Midnights (3 + the Ice Spice remix of "Karma",
      `sql/music_videos_midnights.sql`), The Tortured Poets Department
      (2, `sql/music_videos_ttpd.sql`), and The Life of a Showgirl incl.
      The Encore (4, `sql/music_videos_showgirl.sql`). Every URL
      verified via oEmbed.
      Policy decision made along the way: a secondary channel called
      `@TheTaylorsVersion` hosts several re-recording videos (We Are
      Never Ever Getting Back Together TV, I Knew You Were Trouble TV,
      22 TV, Red TV, The Last Time TV) but doesn't count as "her
      channel" — user confirmed `@TaylorSwift` only, so those
      recordings are left NULL and correctly borrow/label the
      original's video instead.
      The Wikipedia-infobox method (fetch the song's own Wikipedia
      page, read the "Music video" field, then verify via oEmbed)
      turned out much faster and more reliable than raw YouTube
      search, which kept surfacing fan reuploads — used for everything
      from 1989 onward.
      A nice emergent result: bonus-track recordings that are
      alternate takes of an already-videoed song (e.g. "Mine" pop mix
      on Speak Now, "Red" demo on Red) automatically borrow and label
      that song's video too, with no extra code — confirmed live.
      *The Life of a Showgirl* is still an active era with singles
      continuing to roll out, so revisit `sql/music_videos_showgirl.sql`
      as more are released.

- [x] Added `sql/schema.sql` — and in the process discovered and fixed
      a real problem: the schema/seed chain didn't actually rebuild
      from a clean checkout at all. Root cause: *1989* and *1989
      (Taylor's Version)* were the original pre-existing data this
      project started from, before the sql/ seed-file convention
      existed — so no seed file for them ever existed, and every
      later script's artist lookups (Taylor Swift, Max Martin,
      Shellback, Nathan Chapman, and several others) silently
      depended on that unscripted data already being there.
      Fixed by:
      - `sql/0000_core_artists.sql` — bootstraps the 4 artists no
        script ever inserts (Taylor Swift, Max Martin, Shellback,
        Nathan Chapman).
      - `sql/2014_1989.sql` + `sql/2023_1989_taylors_version.sql` —
        reconstruct the original 1989 data from the live database,
        matching it exactly (confirmed by diffing a full rebuild
        against production — see below), including pre-existing data
        gaps like several Taylor's Version tracks having no producer
        credit recorded at all.
      - Renamed `sql/2020_folklore.sql` → `sql/2020_07_folklore.sql`
        and `sql/2020_evermore.sql` → `sql/2020_12_evermore.sql` so
        they sort in the order evermore's script actually needs
        (it reuses Joe Alwyn/Justin Vernon/Aaron Dessner, all added
        in folklore's script).
      - Moved the "Aaron Dessner" and "Christopher Rowe" first-inserts
        to the chronologically-correct files (`sql/2020_07_folklore.sql`
        and `sql/2021_fearless_taylors_version.sql`) instead of files
        that ran too late to satisfy earlier lookups.
      - Fixed a duplicate "Sounwave" artist row — inserted fresh in
        both `sql/2019_lover.sql` and `sql/2022_midnights.sql` — in
        both the seed files and (since it had already happened) the
        live database itself: merged the two rows, repointed the 8
        credit rows that referenced the duplicate.
      - Rewrote every `sql/music_videos_*.sql` file to key its
        `UPDATE`s by `(song title, version_type)` lookup instead of a
        hardcoded `recording_id` — the live database's IDs already
        have unexplained historical gaps (e.g. `recordings` jumps from
        37 to 120 between pre-existing and session-added data), so
        hardcoded IDs were never going to survive a fresh rebuild.
      - Caught two more pre-existing data gaps this surfaced (Clean
        TV and You Are in Love TV both have no producer credit
        recorded) and one feature-parity gap (1989 TV's 5 vault
        tracks were never tagged `edition='From the Vault'`, unlike
        every other album's vault tracks) — fixed live too.
      Verified by dropping a scratch database, running `schema.sql` +
      every seed file in filename order, and diffing the *entire*
      catalog (every track, credit, duration, edition tag, and music
      video URL, across all 16 albums) against production: exact
      match, zero differences.
- [x] Styling pass — "clean, modern, easily accessible" per the user.
      Added `backend/style.css` (a single hand-written stylesheet, no
      framework): light/dark palette via `prefers-color-scheme` and
      CSS custom properties, a card grid of album covers on the
      homepage, a sticky-feeling header with a real `<nav>`, tables
      wrapped for horizontal scroll on mobile, and visible
      `:focus-visible` rings throughout. Added `backend/head.php`
      (shared `<meta>`/title/stylesheet block) and reworked
      `backend/nav.php` into a semantic `<header>`/`<nav>` that marks
      the current page with `aria-current="page"`. Accessibility
      specifics: a "skip to content" link, `<label>` on the search
      input (visually hidden, still announced), descriptive `alt` text
      on every album cover (was `alt=""` on the homepage before),
      `<caption>` + `scope="col"` on both tables, and a visually-hidden
      "(opens in a new tab)" hint on music video links. All 4 pages
      verified live (HTTP 200, no PHP errors, correct markup/ARIA via
      curl) after the change.
- [x] Added `backend/compare_albums.php` — a whole-album comparison
      (not just one song): pick any two albums from a dropdown and
      see every song either one contains, merged into one table
      (Album A's track order first, then anything from Album B that
      A doesn't have). Shared songs line up on the same row so you
      can see e.g. the Nathan Chapman → Christopher Rowe producer
      swap directly; anything unique to one side (vault tracks, etc.)
      is labeled "(only on ...)" and shows dashes on the other side.
      Works for any pair, not just original/Taylor's Version ones —
      tested with two completely unrelated albums (folklore vs
      evermore, zero shared songs) to confirm the merge logic holds
      up generally. Renamed the old "Compare Versions" nav item/page
      to "Compare Songs" so the two comparison modes read clearly as
      siblings: "Compare Songs" (one song, every recording of it) vs
      "Compare Albums" (two albums, every song on either).
- [x] Redesigned Compare Albums per user feedback: the merged 7-column
      table forced horizontal scrolling, so neither album was fully
      visible in the window at once — the opposite of the point.
      Replaced it with two independent columns side by side (each
      album's own tracklist in its own track order, cover + track
      count + total runtime in the header), with rows for songs that
      appear on *both* albums tinted and tagged "(shared)" so the
      overlap is still visible without forcing row-by-row alignment.
      Columns stack vertically under 760px. Re-verified all the same
      cases (original/TV pair, two unrelated albums, single selection,
      invalid ID) live.
- [x] Widened Compare Albums per user feedback — every page shares a
      960px `main` reading-width, which left the two columns squeezed
      into narrow strips in the middle of wide screens. Added a
      `main.wide` CSS rule (1400px) used only on
      `backend/compare_albums.php`; every other page keeps the
      960px width, which suits a single tracklist/search list fine.
- [x] Started the new "themes/moods" phase: search by theme/mood to
      get playlist suggestions. Per user decision: free-form tags
      (no fixed vocabulary) attached per *recording* (not per song),
      since a 10-minute extended cut or an acoustic take can read
      differently from the original even when the underlying song is
      unchanged.
      Schema: `themes` (name `UNIQUE` — learned from the Sounwave
      duplicate-artist bug, so duplicates are impossible by
      constraint, not just convention) + `recording_themes` junction.
      Migration: `sql/0003_add_themes.sql`.
      Feature: `backend/moods.php` — a chip-style multi-select of
      every theme (with a live count of how many recordings carry
      it), builds a ranked "playlist" of matching recordings on
      submit. Matching is OR across selected themes, with tracks
      matching *more* of the selected themes ranked first (ties broken
      by album release date/track number); each result shows which of
      its themes matched, for transparency.
      **Important caveat, flagged to the user up front**: unlike
      every other fact in this database, themes are my own
      interpretation of each song's content — there's no Wikipedia
      infobox to verify against, so treat them as a first draft, not
      ground truth.
      Did the Fearless era (all 19 original + 26 Taylor's Version
      recordings, 42 distinct tags, shared songs tagged identically on
      both versions) as the trial run, same pattern as the music video
      rollout. Seed data: `sql/themes_fearless.sql`. Verified the whole
      feature live — chip rendering, multi-theme OR matching with
      correct match-count ranking, per-track theme transparency, and
      the empty-result state for an unused/invalid theme.
      Full-catalog rollout to the remaining 15 albums is still
      pending — see backlog.
- [x] Consolidated the Moods playlist per user feedback: originally
      grouped by *recording*, so a song with both an original and a
      Taylor's Version (tagged identically) showed up twice — 15
      "tracks" for heartbreak+moving on when there were really only 9
      distinct songs. Regrouped by song: `match_count` is now how many
      of the selected themes appear on *any* recording of that song,
      and each result shows one representative recording (preferring
      the original) for its album/duration, with a "(compare
      versions)" link — reusing the existing Compare Songs page —
      appearing only when the song actually has more than one
      recording. Verified live: the same heartbreak+moving on search
      now returns 9 correctly-ranked songs with no duplicates.
- [x] Themes rollout, album 1 of 15: the 2006 debut "Taylor Swift"
      (11 songs, no Taylor's Version, one recording per song). Seed
      data: `sql/themes_debut.sql`. Added 7 new tags on top of
      Fearless's 42 (49 total), 33 new `recording_themes` rows (168
      total). Verified counts and per-song tag content in the
      database, and spot-checked live via `moods.php` (nostalgia
      search correctly includes Tim McGraw, Mary's Song, Our Song
      alongside the Fearless-era matches).
- [x] Themes rollout, album 2 of 15: Speak Now + Speak Now (Taylor's
      Version). 16 songs shared between both versions, "If This Was
      a Movie" original-only (never re-recorded for TV), 6 vault
      tracks TV-only — 39 recordings tagged. Seed data:
      `sql/themes_speaknow.sql`. Added 19 new tags (68 total), 117
      new `recording_themes` rows (285 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (heartbreak+nostalgia correctly surfaces Last Kiss
      and Timeless alongside earlier-era matches).
- [x] Themes rollout, album 3 of 15: Red + Red (Taylor's Version).
      19 songs shared between both versions, 9 vault tracks TV-only.
      Special case: All Too Well (10 Minute Version) is tagged
      *separately* from the standard-length recordings — the exact
      scenario the per-recording (not per-song) design was meant
      for, since the extended cut's extra verses read noticeably
      more specific/cathartic than the 4-minute version. Seed data:
      `sql/themes_red.sql`. Added 21 new tags (89 total), 147 new
      `recording_themes` rows (432 total). Verified counts, the
      All Too Well special case, and live via `moods.php` (a
      catharsis-only search correctly surfaces All Too Well with a
      "(compare versions)" link, even though only the 10-minute
      recording carries that tag).
- [x] Themes rollout, album 4 of 15: 1989 + 1989 (Taylor's Version).
      16 songs shared between both versions, 5 vault tracks TV-only.
      Seed data: `sql/themes_1989.sql`. Added 11 new tags (100
      total), 111 new `recording_themes` rows (543 total). Verified
      counts and per-song content in the database, and spot-checked
      live via `moods.php` (a humiliation-only search correctly
      surfaces "Is It Over Now?").
- [x] Themes rollout, album 5 of 15: reputation. No Taylor's
      Version yet, so one recording per song, 15 songs. Seed data:
      `sql/themes_reputation.sql`. Added 3 new tags (103 total), 45
      new `recording_themes` rows (588 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (a devotion-only search correctly surfaces "New
      Year's Day").
- [x] Themes rollout, album 6 of 15: Lover. No Taylor's Version yet,
      so one recording per song, 18 songs. Seed data:
      `sql/themes_lover.sql`. Added 3 new tags (106 total), 54 new
      `recording_themes` rows (642 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (an empowerment-only search correctly surfaces
      "The Man").
- [x] Themes rollout, album 7 of 15: folklore. No Taylor's Version
      yet, so one recording per song, 17 songs. Seed data:
      `sql/themes_folklore.sql`. Added 11 new tags (117 total), 51
      new `recording_themes` rows (693 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (a tranquility-only search correctly surfaces
      "the lakes").
- [x] Themes rollout, album 8 of 15: evermore. No Taylor's Version
      yet, so one recording per song, 17 songs. Seed data:
      `sql/themes_evermore.sql`. Added 5 new tags (122 total), 51
      new `recording_themes` rows (744 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (a letting-go-only search correctly surfaces
      "it's time to go").
- [x] Themes rollout, era 9 of 11 (the "15" in earlier entries was
      an overcount — there are 16 albums total, counted as one era
      each for the 3 Taylor's Version pairs plus 10 standalone
      albums, no separate Encore/anthology row): Midnights (the
      combined 3am + Till Dawn edition, one album entry in this
      catalog). No Taylor's Version, one recording per song, 22
      distinct songs (the "Snow on the Beach" and "Karma" remixes
      aren't separately tagged). Seed data: `sql/themes_midnights.sql`.
      Added 7 new tags (129 total), 66 new `recording_themes` rows
      (810 total). Verified counts and per-song content in the
      database, and spot-checked live via `moods.php` (an
      exhaustion-only search
      correctly surfaces "You're Losing Me").
- [x] Themes rollout, era 10 of 11: The Tortured Poets Department
      (The Anthology edition, all 31 tracks as one album entry). No
      Taylor's Version, one recording per song. Seed data:
      `sql/themes_ttpd.sql`. Added 10 new tags (139 total), 93 new
      `recording_themes` rows (903 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (a tenderness-only search correctly surfaces
      "Robin").
- [x] Themes rollout, era 11 of 11 (final album): The Life of a
      Showgirl. No Taylor's Version (brand new release), one
      recording per song, 16 songs. Seed data:
      `sql/themes_showgirl.sql`. Added 9 new tags (148 total), 48
      new `recording_themes` rows (951 total). Verified counts and
      per-song content in the database, and spot-checked live via
      `moods.php` (a euphoria-only search correctly surfaces "Pink
      Clouding").
      **Full-catalog themes rollout complete.** Confirmed with a
      final sweep: every song in the database has at least one
      recording carrying at least one theme tag (query returned zero
      untagged songs). 148 free-form tags across 951
      `recording_themes` rows, spanning all 16 albums/trial run.
      Standing caveat still applies to the whole feature: themes are
      my own reading of each song, not sourced from Wikipedia or any
      other authority like the rest of this database — treat them as
      a considered first draft, not ground truth, and especially so
      for The Life of a Showgirl given how recent it is.
- [x] Built the 4 documentation pages from the user-proposed feature
      backlog (first item tackled from that list): `backend/about.php`
      (project purpose, tech stack, portfolio framing, link to the
      GitHub repo), `backend/data_sources.php` (Wikipedia for
      catalogue data, iTunes Search API for artwork, YouTube oEmbed
      for music-video verification, plus the standing caveat that
      themes/moods are unverified), `backend/privacy.php` (no
      accounts, no analytics, no cookies — nothing to say beyond
      that), and `backend/credits.php` (Image Credits & Licences —
      documents that all artwork comes from the iTunes Search API,
      is copyrighted by the respective label/artist, used here only
      for identification on a non-commercial fan project, and
      explicitly flagged for review before any public/commercial
      deployment).
      Also added `backend/footer.php`, a shared footer partial
      (unofficial-fan-project notice + links to all 4 pages) now
      included on every page — this covers "Clear Unofficial
      Branding" from the same backlog, sitewide rather than as its
      own separate page. Styled in `style.css` to match the existing
      site-header pattern. Verified live: all 4 pages return 200,
      the footer renders exactly once on every existing page, no
      PHP errors in the dev server log.
- [x] Built Song Recommendations (second item from the user-proposed
      feature backlog), which needed a new song detail page first —
      `backend/song.php?song_id=X` — since songs previously only
      appeared embedded in `tracklist.php` rows or `compare.php`.
      The page shows a song's themes, every recording (version,
      album, duration, credits, music video), a link to
      `compare.php` when there's more than one recording, and a
      "Similar songs" section: other songs sharing at least one
      theme, ranked by how many themes they share (ties broken
      alphabetically), each showing exactly which themes are shared
      — directly reusing the `recording_themes` data from the
      themes rollout, no new schema needed. Matching is done at the
      song level (any recording vs. any recording), same approach
      as the Moods playlist, so an original/Taylor's Version pair
      doesn't inflate its own shared-theme count.
      Wired up links to the new page from every place a song title
      already appears: `tracklist.php`, `search.php`, `moods.php`,
      and `compare_albums.php`.
      Verified live: "All Too Well" correctly ranks "Babe" above
      "Bad Blood" (3 shared themes vs. 2) with the right theme names
      listed for each; a song with no themes shows an explanatory
      message instead of an empty "Similar songs" section; invalid/
      missing `song_id` both error the same way the rest of the site
      does; no PHP errors in the dev server log.
- [x] Built the Catalogue Statistics Dashboard (third item from the
      user-proposed feature backlog) — `backend/stats.php`, added
      to the main nav. Headline numbers (albums, songs, recordings,
      themes tagged, combined runtime, songs with a music video,
      vault-track count, outside-collaborator count) plus: a
      per-album table (track count, total length, average track
      length) with the longest/shortest album called out; longest/
      shortest individual recording; top 10 most frequent outside
      songwriters/producers; the 12 most common themes by distinct
      song count, each linking straight into `moods.php`; and a
      breakdown of recordings by version type. All pure aggregate
      SQL over existing tables, no new schema.
      Added a `'other'` mapping to `format_version_type()` in
      `helpers.php` ("extended version") since that's the version
      type used for All Too Well (10 Minute Version) and it was
      previously falling through to the raw enum value.
      Verified live: all headline numbers and the per-album/
      collaborator/theme breakdowns match direct database counts,
      the longest recording correctly resolves to All Too Well (10
      Minute Version) at 10:13, no PHP errors in the dev server log.
      **This completes all three items the user picked from the
      feature backlog, in order: documentation pages, Song
      Recommendations, Catalogue Statistics Dashboard.**
- [x] Made the Stats page's Collaborations and Versions & editions
      lists clickable, per user follow-up request. Collaborator
      names link to `search.php?q=<name>`, reusing the existing
      songwriter/producer name search as-is — no changes needed
      there. Version types link to a new `backend/version.php?type=X`
      page listing every recording of that type (song, album,
      duration), each song linking into `song.php`. Verified live:
      "original" correctly lists all 218 recordings, "other"
      correctly isolates just All Too Well (10 Minute Version), an
      invalid/missing `type` errors the same way the rest of the
      site does, no PHP errors in the dev server log.
- [x] Added Favourite Songs — this project's first client-side
      JavaScript (`backend/favorites.js`), chosen over PHP sessions
      specifically to avoid cookies and keep the Privacy page's "no
      cookies" claim true. Favourites are stored in `localStorage`
      as `{song_id: title}`, nothing sent to a server.
      A star toggle button (`favourite_toggle_html()` in
      `helpers.php`) was added next to every song title on
      `song.php`, `tracklist.php`, `search.php`, and `moods.php`
      (still to do on `compare.php`, `compare_albums.php`,
      `version.php` — see backlog). New `backend/favourites.php`
      page lists everything starred, rendered entirely client-side,
      with a `<noscript>` fallback explaining the feature needs JS.
      `backend/scripts.php` is a new shared partial (parallel to
      `footer.php`) that includes `favorites.js`, added to every
      page with a star button.
      Updated `privacy.php` to describe this concretely instead of
      speaking hypothetically about future personalisation features.
      Verified live: all touched pages return 200, the button
      markup and `aria-pressed`/`aria-label` attributes render
      correctly, `favorites.js` passes `node -c` syntax check and is
      served at 200, no PHP errors in the dev server log. Actual
      click-through/localStorage behavior wasn't tested in a real
      browser this session — worth a manual click-test next time.
- [x] User confirmed the real-browser click-test: favourites set
      last session were still present at the start of this one.
      Added the remaining star buttons for full site coverage:
      `compare.php` (both the song-list view and the per-song
      version-comparison view), `compare_albums.php` (per-track in
      each album's tracklist), and `version.php` (per-recording in
      the by-version-type list). All three needed `require
      __DIR__ . '/helpers.php'` added (only `version.php` already
      had it) and `scripts.php` included after the footer. Verified
      live: all four page variants return 200, the button markup
      and `favorites.js` include both render correctly, no PHP
      errors in the dev server log. Favourite Songs now has a star
      next to every song title anywhere on the site.
- [x] Built the Favourite Song Tournament — `backend/tournament.php`
      + `backend/tournament.js`, in the main nav. Per user spec:
      single-elimination bracket (pick a winner between two songs,
      loser's out for good, winners keep pairing up), covering the
      whole catalogue. Catalogue size (245) isn't a power of two, so
      the bracket pads up to the next one (256) by giving 11 songs
      a silent bye into round 2 — everyone else just sees a clean
      run of matchups. Progress (current round, remaining matches,
      every pick so far) is saved to `localStorage` after every
      single pick, not just at round boundaries, since a full
      tournament is ~244 picks across 8 rounds and realistically
      spans many sessions — explicitly the point of a user-reported
      similar app taking about 8 hours to finish. On reaching a
      champion, results are grouped by the round each song was
      eliminated in (Runner-up, Semifinalists, Quarterfinalists,
      ... down to Round 1) — the same "rank by how far you got"
      logic as a sports bracket. "Start over" clears saved progress
      with a confirm prompt first.
      Chose client-side JS + localStorage over a server session for
      the same reason as Favourites: avoids introducing cookies.
      Updated `privacy.php` to cover it alongside Favourites.
      Verified the bracket math itself with a standalone Node
      simulation of the pairing/round-advancing logic (not the real
      browser DOM): for 245 songs it produces exactly 244 picks
      across 8 rounds with byes landing correctly, matching the
      hand-calculated numbers from the design discussion. Also
      verified live: page returns 200, `tournament.js` passes
      `node -c`, the embedded song list matches the DB's 245 songs,
      no PHP errors in the dev server log. **Not yet click-tested in
      a real browser** — that's the natural next check now that the
      user is back at their laptop.

- [x] Added all 9 non-album singles/soundtrack songs the user asked
      for: **Crazier** (Hannah Montana: The Movie, 2009),
      **Safe & Sound** (The Hunger Games, 2011, with The Civil
      Wars), **Eyes Open** (The Hunger Games, 2012),
      **Sweeter than Fiction** (One Chance, 2013),
      **Beautiful Ghosts** (Cats, 2019, with Andrew Lloyd Webber),
      **Christmas Tree Farm** (standalone holiday single, 2019),
      **Only the Young** (Miss Americana, 2020),
      **Carolina** (Where the Crawdads Sing, 2022), and
      **I Knew It, I Knew You** (Toy Story 5, 2026). Every
      songwriter/producer credit and duration was verified via web
      search across multiple sources first (Wikipedia plus news
      coverage), same standard as the rest of the catalogue — see
      `sql/nonalbum_singles.sql` for full sourcing notes.
      Schema needed no changes: `albums.album_type` already had
      'single' and 'soundtrack' as options, unused until now. Each
      song got its own one-track "album" row (matches how streaming
      services list a standalone single).
      7 new artists added (T Bone Burnett, Joy Williams, John Paul
      White, Andrew Lloyd Webber, Greg Wells, Tom Hooper, Jimmy
      Napes) — `artists.name` has no UNIQUE constraint (the same gap
      that caused the earlier Sounwave duplicate-artist bug), so
      each was inserted with an explicit `NOT EXISTS` guard rather
      than relying on a constraint that isn't there.
      **Found and fixed a real bug this surfaced**: `index.php`'s
      homepage grid listed every row in `albums` with no filter, so
      these 9 one-song singles started appearing interleaved with
      real studio albums on a page titled "Albums." Filtered the
      main grid to `album_type NOT IN ('single', 'soundtrack')` and
      added a separate "Non-album singles & soundtrack songs" list
      below it, linking each one straight to its `song.php` page.
      Verified live: all 9 songs, their credits, and their
      durations match the research; `artists` has zero duplicates;
      totals moved from 16→25 albums, 245→254 songs, 325→334
      recordings, 76→83 outside collaborators (exactly the 7 new
      artists) on `stats.php`; the iTunes artwork lookup worked
      automatically for the new "albums" with no code changes;
      homepage correctly shows 16 real albums plus the new singles
      list; no PHP errors in the dev server log.
      Not yet done: themes/moods tags and music-video verification
      for these 9 songs (left untagged/unlinked for now, consistent
      with being honest about what's actually been checked).
- [x] Redesigned the homepage around **Eras** instead of a flat list
      of 16 album rows, per user request — a studio album and its
      Taylor's Version re-recording are the same era to fans, not
      two separate things, and mixing eras up "feels wrong."
      Real schema addition, not just a display change: new `eras`
      table (`era_id`, `name`, `icon`) and a nullable `albums.era_id`
      FK — migration `sql/0004_add_eras.sql` (schema only, same
      pattern as 0001-0003), data + backfill in `sql/eras_seed.sql`
      (run after the dated catalog files, same as any other seed
      file). `schema.sql` updated to match, including the DROP/
      CREATE order (`albums` must drop before `eras`, since it
      holds the FK; `eras` must create before `albums`).
      `icon` is the colored heart fans/Taylor Nation use per era on
      social media — verified via web search after my first
      instinct (an arbitrary emoji per era, e.g. 🐍 for reputation)
      turned out to not be what the user meant. Corrected again
      mid-build on user correction: The Life of a Showgirl uses the
      "heart on fire" (❤️‍🔥) rather than a plain colored heart,
      matching her own marketing account's usage.
      `backend/index.php` rewritten: one card per era (icon + name),
      with the original and Taylor's Version nested side-by-side
      inside the same card when both exist, labeled "Original"/
      "Taylor's Version"; single-album eras just show one cover,
      unlabeled. Non-album singles section unchanged, now keyed off
      `era_id IS NULL` instead of `album_type`.
      `artists.name`-style duplicate risk doesn't apply here since
      `eras.name` got a `UNIQUE` constraint from the start (learned
      from both the Sounwave bug and the themes-table precedent).
      Verified live: all 12 eras render in correct chronological
      order (by each era's earliest album), icons match the
      corrected list, original/TV pairs nest correctly under
      Fearless/Speak Now/Red/1989, `eras_seed.sql` is idempotent on
      re-run, no PHP errors in the dev server log.
      **Open question for the user, not yet acted on**: whether this
      replaces the need for the separate Compare Albums page. My
      read: no — Compare Albums does full tracklist-level comparison
      with shared-song highlighting between *any* two albums
      (including across eras, e.g. Lover vs. Midnights), which the
      homepage's lightweight icon+cover view doesn't attempt. Leaning
      toward keeping both unless the user still wants it gone after
      seeing the new homepage.
- [x] Added Undo and per-album win statistics to the Tournament, per
      user request (hit a misclick mid-run and wanted a safety net,
      plus curiosity about which album "wins" the most overall).
      Undo is a full multi-level stack, not just one step back:
      `pick()` now pushes a JSON-cloned snapshot of the pre-pick
      state onto `state.history` before mutating anything, and
      "Undo last pick" just pops and restores the most recent one —
      chosen over manually reversing each mutation because round
      transitions (the queue/winners reset that happens when a
      round completes) are easy to get subtly wrong by hand; a full
      snapshot restore can't be wrong in that way. Verified the
      approach with a standalone Node simulation: a misclick
      followed by undo-and-correct produces an identical champion
      and pick count to a clean run; also verified 2 consecutive
      undos and undoing the final championship-deciding pick both
      restore exactly the expected prior state.
      Win statistics: `tournament.php`'s song query now also
      fetches each song's representative album (same "prefer
      original, earliest release" pattern as `moods.php`/
      `song.php`). `pick()` increments a `wins` counter per
      song_id (byes don't count as a win, matching real bracket
      semantics). The results screen now shows every album's total
      wins across its songs, most-to-least, explicitly calling out
      the highest and lowest — including albums whose songs lost
      every match they played, so "fewest winners" has a real
      answer instead of only covering albums with at least one win.
      Both features are backward-compatible with the tournament the
      user already has in progress: old saved state is missing the
      new `history`/`wins` fields, which just default to empty on
      load, so it resumes correctly — undo and the album stats only
      cover picks made from this update onward, which was explained
      to the user rather than silently assumed.
      Verified live: page and script both return 200, `tournament.js`
      passes `node -c`, the embedded song list now includes each
      song's album, no PHP errors in the dev server log.
- [x] Turned Tournament results into a saveable, length-limited
      playlist, per user request after finishing their first full
      run. Ranking for this is tier-based (champion, then runner-up,
      then semifinalists, ... down to round-1 losers) — songs
      eliminated in the same round are genuinely tied in a knockout
      bracket (they never played each other), so a length that cuts
      mid-tier just takes them in whatever order they happened to
      resolve in; this was a deliberate simplification, not an
      oversight, and there isn't really a better answer without
      re-running extra matches the user never asked for.
      New shared storage module `backend/playlists.js`
      (`window.TSPlaylists`: save/readAll/remove/removeSong,
      `localStorage` only, same no-account approach as everything
      else) — deliberately generic (name + ordered song list) rather
      than tournament-specific, so a future manual "build your own
      playlist" feature (still in the backlog below) can reuse the
      exact same storage and viewer without rework.
      `tournament.php`'s song query extended to pull each song's
      representative album_id/title/duration (previously just
      album title, for the win-stats) — one subquery for the
      recording_id, then a plain join, rather than three duplicated
      correlated subqueries.
      `tournament.js`: results screen now has a length input +
      "Generate" button producing the ranked/truncated list (title,
      album, duration, linking to `song.php`), then a name field +
      "Save playlist" button.
      New `backend/playlists.php` (added to nav as "My Playlists")
      + `backend/playlists_view.js` (rendering only; storage stays
      in playlists.js) lists every saved playlist as a card with a
      delete-playlist button and a per-song remove button.
      Updated `privacy.php` to cover playlists alongside favourites/
      tournament progress.
      Verified: `playlists.js`'s storage functions (save/readAll/
      removeSong/remove) tested directly in Node with a minimal
      localStorage polyfill — all four operations work correctly;
      the tier-ranking logic simulated separately (8-song bracket)
      confirms champion-first ordering, correct total length, and
      sensible mid-tier truncation; all new/changed pages and
      scripts return 200 and pass `node -c`; no PHP errors in the
      dev server log. Not click-tested in a real browser.
- [x] Made the Tournament operate on *recordings* instead of
      *songs*, per user feedback after finishing their first run:
      the original and the Taylor's Version of a song are distinct
      entities with genuinely different fan opinions (their own
      example: Swifties strongly debating "Style" original vs. the
      more heavily produced Taylor's Version), so collapsing them
      into one entry was inaccurate. Same reasoning the themes
      feature already uses for tagging per recording rather than
      per song (`sql/0003_add_themes.sql`).
      `tournament.php` now queries `recordings` joined to `songs`
      (not the other way around), one entity per `recording_id`.
      The original keeps the bare song title; every other version
      gets a plain-English suffix built from the existing
      `format_version_type()` helper — "Style (Taylor's Version)",
      "All Too Well (Extended Version)", "Back to December
      (Acoustic Version)", etc. Catalogue size for the bracket goes
      from 254 to 334, so the bracket is now size 512 (178 byes, 333
      total picks, 9 rounds instead of 8) — a real tradeoff of the
      accuracy fix, called out to the user rather than left as a
      surprise.
      Added a `schemaVersion` field to the saved tournament state:
      an old save (from before entities were per-recording) now
      gets discarded with a one-time on-page notice explaining why,
      rather than silently rendered with mismatched fields — the
      previous update's "just default missing fields" approach
      wasn't safe here since the entity shape itself changed, not
      just which fields exist on it.
      **Found and fixed a second bug this surfaced**: playlist
      song-removal (`playlists.js`'s `removeSong`) matched by
      `song_id`, which stopped being unique within a playlist once
      a playlist could contain both "Style" and "Style (Taylor's
      Version)" — removing one would've silently removed both.
      Changed to `removeSongAt(playlistId, index)`, removing by
      position instead, which can't collide no matter what. Updated
      the one call site in `playlists_view.js` to pass the array
      index from its `forEach`.
      Also fixed the "How everyone else did" results list: it
      joined tied songs with ", ", which is genuinely ambiguous
      when titles contain commas themselves (user's example: "So
      Long, London"). Changed to a nested list — one song per line,
      each linking to `song.php` — instead of trying to find a
      delimiter that's merely "probably" safe.
      Verified: live queries confirm "Style"/"Style (Taylor's
      Version)", all three "All Too Well" variants (original/TV/
      Extended), and acoustic/remix/demo labels all render
      correctly; total count is 334; bracket math re-simulated for
      n=334 (512/178 byes/333 picks/9 rounds); the playlist
      removal fix re-tested in Node with the exact "both Style
      versions in one playlist" scenario — removing one correctly
      leaves the other; all touched files pass `node -c` and return
      200; no PHP errors in the dev server log.
- [x] Corrected the Tournament's title for the All Too Well 10
      Minute Version: it was showing the generic "(Extended
      Version)" suffix, but the real, fan-recognized title is "All
      Too Well (10 Minute Version) (Taylor's Version) [From the
      Vault]" — verified via web search (user flagged it from
      memory; confirmed before changing, same standard as the rest
      of the catalog). Hardcoded in `tournament.php` rather than
      generalized: "10 Minute Version" isn't a label derivable for
      any other song from the current schema, and there's only one
      `version_type = 'other'` recording in the whole catalogue, so
      a generic rule would be solving a problem that doesn't exist
      yet. Didn't bump the tournament's `schemaVersion` for this —
      it's a display-string fix, not a change to the entity shape,
      so an in-progress run doesn't need to be discarded over it.
      Verified live: the three "All Too Well" entries now read
      "All Too Well", "All Too Well (Taylor's Version)", and "All
      Too Well (10 Minute Version) (Taylor's Version) [From the
      Vault]"; no PHP errors in the dev server log.
- [x] Rebuilt the Tournament as double-elimination, per user
      request after discussing the limits of single elimination: a
      song that loses can unluckily be facing one of your other
      favourites, not necessarily a worse song, and single
      elimination has no way to give it a second chance. Added
      "Reject both" for the opposite case the user also raised —
      two songs you don't like/know, forced into a winner anyway.
      Deliberately a *simplified* double elimination, not the
      traditional interleaved kind: the Winners Bracket runs to
      completion first, every WB loser is collected into a pool,
      that pool runs as its own Losers Bracket, then the two bracket
      champions meet in one Grand Final. A real interleaved
      double-elim (LB rounds running concurrently with WB rounds,
      carefully avoiding immediate rematches) is the competitive-
      bracket-correct version, but meaningfully harder to schedule
      correctly — this gets the same core guarantee (nobody's fully
      out after one loss) without that complexity. Disclosed this
      simplification to the user rather than silently picking it.
      "Reject both" is available in either bracket (permanent, no
      third chance — that's the point) but not the Grand Final,
      since both finalists already proved themselves once.
      Rewrote `tournament.js` around a reusable sub-bracket engine
      (`buildSubBracket`/`resolveMatch`) used for both WB and LB,
      with a `phase` state machine (winners → losers → final → done)
      on top. Final ranking: champion, runner-up, then LB-eliminated
      songs by how far they got in the LB (second-chance survival is
      a real achievement), then "Reject both" casualties at the very
      bottom (an explicit "didn't like either" is a stronger
      negative signal than an ordinary loss). Bumped
      `schemaVersion` to 3 (structure changed completely) — an old
      save gets discarded with a one-time explanatory notice, same
      pattern as the previous schema bump.
      **Caught and fixed two real bugs via simulation before calling
      this done, not after**:
      1. A round that shrinks by 2 (one "reject both") instead of 1
         can leave an odd number of winners going into the next
         round — `pairUp()` would silently pair the last one with
         `undefined`. Fixed by giving the odd one out a bye into the
         next round, same mechanism as the byes a bracket starts
         with.
      2. `resolveMatch` was unconditionally recording a match's
         losers into `sub.eliminated`, while the "reject both"
         caller *also* recorded them into `state.rejectedBoth` —
         same two songs counted twice in the final ranking whenever
         "reject both" was used. Fixed by only recording into
         `sub.eliminated` for a normal pick.
      Verified via extensive Node simulation (not a real browser,
      which isn't available in this environment): 50 randomized
      trials across catalogue sizes 10-50 with ~20% random "reject
      both" usage, re-run multiple times with different random
      seeds, all producing a complete, duplicate-free ranking;
      explicit tests for the odd-leftover-bye fix, the degenerate
      "reject every single match" case (resolves to no champion
      with a friendly message, no crash, no infinite loop), and undo
      correctly reversing a WB→LB phase transition. Also verified
      live: page returns 200, `tournament.js` passes `node -c`, no
      PHP errors in the dev server log.
      **Real cost of this change, flagged to the user**: total picks
      for the full 334-recording catalogue goes from 333 (single
      elimination) to roughly 666 (333 WB + 332 LB + 1 final) —
      close to double the time commitment, as a direct consequence
      of giving every song a genuine second chance.
- [x] Accessibility + Responsive Design pass, focused on the newer
      interactive features (Tournament, Playlists) per the backlog's
      own note that this was the right time to do it. Audited
      contrast, alt text, heading hierarchy, landmarks, keyboard
      operability, focus styling, screen-reader announcements for
      JS-driven updates, and nav wrapping at narrow widths.
      **Confirmed already solid, no changes needed**: every text/
      background color pair passes WCAG AA (computed contrast
      ratios directly, lowest was 6.47:1 against a 4.5:1 minimum);
      every `<img>` has real alt text; every click handler in
      `favorites.js`/`tournament.js`/`playlists_view.js` is attached
      to an actual `<button>` (confirmed none on a bare div/span),
      so everything is keyboard-reachable and operable by default;
      the global `button:focus-visible`/`a:focus-visible` rule
      covers every custom control; no animations exist anywhere, so
      there's nothing for `prefers-reduced-motion` to reduce; the
      favourite star's `aria-label` already correctly overrides the
      visible ★/☆ glyph as the accessible name.
      **Real issues found and fixed**:
      1. `search.php` skipped from `<h1>` straight to `<h3>` for
         each result card, with no `<h2>` — fixed to `<h2>`, with a
         scoped `.result-card h2` rule keeping the same visual size
         as before so this is a semantic fix only, not a redesign.
      2. No screen-reader announcement existed for any JS-driven
         content swap. Added a dedicated `role="status"` /
         `aria-live="polite"` region to `tournament.php` (announces
         each pick/reject/undo and the final result) and
         `playlists.php` (announces playlist/song deletion) —
         deliberately a small dedicated region per page rather than
         making the whole rebuilt list live, which would re-announce
         everything on every small change. Favourites didn't need
         this: its star buttons are proper ARIA toggles
         (`aria-pressed` + a dynamic `aria-label`), which screen
         readers already announce on their own.
      3. **The most significant find**: `.site-nav ul` had no
         `flex-wrap`, and the nav has grown to 9 items (Home,
         Search, Compare Songs, Compare Albums, Moods, Stats,
         Favourites, Tournament, My Playlists) since this rule was
         written for a 5-item nav. At any width too narrow to fit
         all 9 in one row, the nav would overflow horizontally
         rather than wrap — a real bug on every single page, not
         just the newer ones. Fixed with `flex-wrap: wrap`. Applied
         the same fix to `.site-footer-nav ul` (4 items, same
         missing property, lower risk but same bug) and added
         `flex-wrap: wrap` to `.tournament-actions` defensively.
      Verified live: all touched pages return 200, both JS files
      pass `node -c`, no PHP errors in the dev server log. The nav
      fix itself is standard, unambiguous CSS behavior; a visual
      check wasn't possible this session since the built-in browser
      tool can't reach `localhost` servers Claude starts itself —
      worth a quick look at a real phone width next time the user's
      at a browser.
- [x] Built the first milestone of user accounts: registration,
      login, logout, and a `users` table — deliberately scoped
      narrowly, per the plan agreed with the user beforehand. Does
      **not** yet sync Favourites/Tournament progress/Playlists to
      an account; that's a separate, deliberate next decision, not
      a side effect of login existing.
      New table `users` (`sql/0005_add_users.sql`, folded into
      `schema.sql`): email (`UNIQUE` — every table gets one now,
      learned from the Sounwave bug), `password_hash`, `display_name`,
      `created_at`. Passwords are never stored or logged directly —
      `password_hash()`/`password_verify()` (bcrypt by default),
      exactly the pattern the user had already shipped successfully
      on a previous project, just moved onto this project's existing
      PDO/prepared-statement house style.
      New `backend/auth.php` — shared session + CSRF helpers,
      required at the very top of all 16 existing pages (before any
      HTML is echoed, since starting a session has to happen before
      any output) so `nav.php` can show login status everywhere
      without touching the database on every page load (login state
      lives in `$_SESSION`, set once at login). `session_regenerate_id()`
      on login (session-fixation hardening), `httponly`/`samesite=Lax`
      on the session cookie, CSRF tokens on both the register and
      login forms.
      New `backend/register.php`, `backend/login.php`,
      `backend/logout.php`. Login's failure message is deliberately
      the same generic "Incorrect email or password" whether the
      email doesn't exist or the password was wrong — doesn't leak
      which registered emails exist. `nav.php` restructured (title |
      nav+auth-status grouped together) to fit "Hi, {name} · Log
      out" or "Log in · Register" without breaking the
      `space-between` header layout.
      Updated `privacy.php` (accounts are optional; what logging in
      actually stores and why; one cookie now exists, but only if
      you choose to log in; existing localStorage features are
      explicitly *not* yet tied to an account) and `about.php` (the
      "no client-side JavaScript" line was already stale from the
      Favourites/Tournament work, fixed while touching nearby copy).
      **Deliberately not built in this milestone** (logged as real
      gaps, not silently skipped): no rate-limiting/lockout on
      repeated failed logins, no "forgot password" flow, no email
      verification. Worth doing before this is ever public.
      Verified with a full end-to-end test using `curl` and a
      cookie jar (not a real browser, which isn't reachable from
      this environment for `localhost`): fetched a real CSRF token
      from the register page and successfully registered an
      account; confirmed `nav.php` showed "Hi, TestUser" immediately
      after; logged out and confirmed the nav reverted; logged back
      in with the same credentials and confirmed it worked; confirmed
      wrong-password, duplicate-email, and invalid-CSRF-token all
      produce the correct error message; queried the database
      directly and confirmed the stored `password_hash` is a real
      bcrypt hash (`$2y$12$...`), not plaintext; deleted the test
      account afterward. All 18 pages pass `php -l` and return 200;
      no errors in the dev server log.
- [x] **Accounts follow-up: server-side validation gaps closed.**
      Found while answering a direct question about whether
      server-side validation was "taken care of" — it mostly was
      (prepared statements, CSRF, hashing, generic login errors were
      all already correct), but two real gaps weren't: (1) no
      max-length checks on `email`/`display_name` against the actual
      `varchar(255)`/`varchar(100)` column sizes, and this DB runs
      with `STRICT_TRANS_TABLES` (confirmed via `SELECT @@sql_mode;`)
      so an overlong value throws rather than silently truncates —
      previously uncaught, would've shown a raw PHP error page; (2)
      no cap on password length, so a password past bcrypt's 72-byte
      practical limit was silently truncated with no warning. Fixed
      both with explicit length checks in `register.php` giving a
      friendly `form-errors` message instead. Also wrapped the
      `INSERT` in a `try`/`catch` for SQLSTATE `23000` (unique
      violation) to close the TOCTOU race between the pre-insert
      duplicate-email `SELECT` and the `INSERT` itself — two
      near-simultaneous registrations with the same email now both
      get the friendly "already exists" message instead of the
      second one crashing. Verified live: posting a 150-character
      display name now renders "Display name must be 100 characters
      or fewer." instead of an uncaught exception.
- [x] **First visual design pass** — user feedback was just "the
      website does not look great," so before changing anything,
      used headless Chrome (`google-chrome --headless --screenshot`,
      with `--blink-settings=preferredColorScheme=1` to force light
      mode, since the default run came back dark — no browser tool
      in this environment can open `localhost`, but a locally
      installed Chrome run straight from the shell isn't going
      through that tool, so this works) to actually see what the
      site looked like before guessing. Found one real bug and
      fixed two things for personality:
      **Bug**: era cards on the homepage had two compounding
      problems, both in `backend/style.css`. (1) `.era-grid` is a
      CSS Grid, which defaults to stretching every item in a row to
      match the tallest — a dead gap was appearing below the cover
      art on every era with only one album (no Taylor's Version),
      since those cards had less natural content than their
      row-siblings. Fixed with `align-items: start`. (2)
      `.era-album { flex: 1 }` meant a *single* cover in a row grew
      to fill the entire card width — combined with `aspect-ratio:
      1/1`, Chrome was visibly not holding that ratio under the
      stretch, rendering those covers as wide rectangles instead of
      squares (confirmed by cropping and comparing screenshots
      pixel-by-pixel before touching any CSS, since this didn't match
      what the CSS alone implied). Fixed by capping
      `.era-album .cover` at `max-width: 150px` instead of changing
      the flex sizing — keeps covers a consistent size whether an
      era has one album or two, without restructuring the markup.
      **Personality**: the whole site used only the system font
      stack, which read as generic/undesigned. Added "Fraunces" (a
      warm variable serif) via Google Fonts for all headings
      (`h1`/`h2`/`h3`, `.site-title`, `.era-name`,
      `.tournament-champion`, `.stat-number`) while keeping the
      existing system sans-serif for body text and UI — a deliberate
      serif-display/sans-body pairing, not a full font swap, so
      tables and buttons stay maximally readable. Also added a hover
      lift + shadow to era cards, slightly increased heading sizes,
      and tightened `.plain-list li` padding (was noticeably
      oversized for single-line entries like the non-album singles
      list).
      Verified by re-screenshotting after each change — the era-card
      fix was confirmed empirically (re-ran the same crop comparison
      and saw genuinely square covers with no gap), not just assumed
      from reading the CSS. Checked home/tracklist/song/stats/
      tournament/login pages. Deliberately scoped to typography +
      the one real bug this round, not a full re-skin — the color
      palette, layout structure, and header nav were left alone
      pending the user's reaction to this first pass.
- [x] **Second visual design pass — full redesign.** User's reaction
      to the first pass: "the colours, the theme, the layout,
      everything needs work." Declined a scoped follow-up round of
      clarifying questions (rejected the question tool outright) and
      just named the problem broadly instead, so this round took
      real creative initiative rather than asking for more specifics
      — a genuine redesign, not another round of small tweaks.
      **Per-era accent colours** — the single biggest change. New
      `era_accent_color()` in `backend/helpers.php`, keyed by era
      name, mapped from the same official coloured-heart emoji
      already verified (not guessed) in `sql/eras_seed.sql` — so
      each homepage era card gets a top border + icon badge in its
      actual real-world brand colour (green debut, gold Fearless,
      purple Speak Now, etc.) via a CSS custom property set inline
      per card (`style="--era-accent: ..."`), rather than one flat
      accent colour everywhere. This did the most work in making the
      site feel like *this* artist's catalogue rather than a generic
      template. One bug caught during dark-mode verification:
      reputation's near-black (`#2b2b2b`) was nearly invisible
      against the dark background — changed to a mid-grey (`#55555c`)
      that reads as "reputation's black" in both themes.
      **Richer palette**: warmer ivory/paper background, a second
      accent colour (warm gold, `--accent-2`) alongside the existing
      wine red, new `--surface-tint` for alternating section
      backgrounds (footer, table zebra striping), bigger `--radius`,
      a `--shadow-lg` for hover states. Values changed, variable
      names didn't — kept every existing `var(--accent)` etc.
      reference working rather than a risky mass rename.
      **Header**: a 4px gradient bar (accent → accent-2) across the
      very top of every page; a ♪ mark before the site title; nav
      links get an accent underline on hover/current page instead of
      just a colour change; login/register became pill-shaped
      buttons instead of plain text links.
      **Everywhere else**: every `h1` gets a short gradient accent
      rule under it (one visual signature repeated site-wide); result
      cards, plain-list items, playlist cards, and stat cards all
      gained a coloured left/top border (alternating between the two
      accents for rhythm) plus a hover lift; buttons got a subtle
      gradient fill instead of flat colour; tables got zebra
      striping. Added an intro paragraph under the homepage's "Eras"
      heading so it doesn't jump straight into the grid with no
      framing.
      **One real bug found and fixed along the way**: the new zebra
      striping (`tbody tr:nth-child(even)`) turned out to have higher
      CSS specificity than the existing `tr.shared-row` highlight on
      Compare Albums, so a shared song landing on an even row would
      silently lose its highlight to the stripe. Fixed by qualifying
      the selector to `tbody tr.shared-row` to match specificity and
      win on source order, rather than reaching for `!important`.
      Verified extensively with headless-Chrome screenshots, light
      and dark, across home/song/tracklist/stats/tournament/search/
      moods/compare-albums/favourites/about — not just the homepage,
      since the shared `style.css` changes touched components used
      everywhere. Caught and corrected my own mistake mid-session:
      misread Chrome's `--blink-settings=preferredColorScheme`
      values backwards (0 is dark, not 2) and nearly reported dark
      mode as checked when both "before" and "after" screenshots
      were actually the same light render — caught by testing the
      flag against a trivial isolated HTML file before trusting it
      again, not by assuming the first screenshot was correct.
      Also deleted a leftover `grapevine` theme (0 uses) created
      during yesterday's profanity-filter testing and never cleaned
      up — caught while screenshotting the Moods page for this pass,
      unrelated to today's actual work but fixed while there.
- [x] **Tournament: split "Reject both" into two honest signals.**
      Found a similar site (tssongsorter.com) and compared it
      directly — see that research below. One of its ideas adopted:
      the old single "Reject both — I don't like or know either of
      these" button conflated two genuinely different signals. Now
      two buttons in `tournament.js`: **"I don't have an opinion"**
      (same behaviour as before — both songs permanently out, ranked
      below even a round-1 Losers Bracket loss) and **"I like them
      both"** (new — the opposite signal, so neither song should be
      penalized). The bracket still mechanically needs one winner per
      match to converge, so one song is picked at random to keep
      representing the pair, but the other is tracked in a new
      `state.likedBoth` list and always displayed **tied** with
      whatever result its partner reaches, not ranked below it — a
      new "Liked equally — ranked together" section on the results
      page, and `rankedSongs()` now splices each set-aside song in
      immediately next to its partner (processing pairs in reverse
      order so a song that keeps representing a tie across several
      rounds — a chain — still resolves correctly). Not offered in
      the Grand Final, same as before (both finalists have already
      proven themselves once; a tied champion is a different problem
      this doesn't try to solve).
      Verified with a real test, not just by reading the code: no
      browser tool here can run arbitrary interactions against
      `localhost`, so installed `jsdom` and drove an 8-song bracket
      through real DOM click events (mixing normal picks, "I like
      them both", and "I don't have an opinion"), then asserted
      directly on the persisted `localStorage` state — confirmed the
      bracket completes, and the set-aside song from a "liked both"
      pair never ends up double-counted in `eliminated` or
      `rejectedBoth`. Caught and fixed a bug in the TEST harness
      itself along the way (jsdom ships its own real `localStorage`
      that silently shadowed a hand-rolled stub, so the first run's
      assertions were reading from an orphaned object) — worth
      recording since it looked exactly like a product bug (state
      never reaching "done") until traced down.
- [x] **Era theme picker — colours and a matching font.** Also from
      the tssongsorter.com comparison. A new `<select>` in the header
      (`nav.php`) lets a visitor match the whole site's accent colour
      *and* display font to a chosen era, live, no reload — reusing
      the per-era colours from yesterday's redesign plus a new font
      pairing per era in `era_theme_options()`
      (`backend/helpers.php`). The font choices are deliberately
      **not** attempts to reproduce any album's actual proprietary
      lettering (reputation's newspaper stamp, Speak Now's cursive
      wordmark, etc. are licensed typography this project has no
      rights to copy) — just a widely-available Google Font in the
      same spirit (a typewriter face for The Tortured Poets
      Department, a marker/handwriting face for 1989's Polaroid
      captions, and so on).
      New `backend/era_theme.js`: reads `window.TS_ERA_THEMES`
      (emitted by `nav.php` from the same PHP source of truth),
      applies the choice by setting `--accent`/`--accent-hover`
      (via `color-mix()`, so no second hardcoded shade is needed per
      era) /`--font-display` directly on `:root`, and loads that
      era's Google Font **on demand** — only when actually selected,
      not all twelve upfront on every page load. Saved to
      `localStorage` only (a cosmetic per-browser preference, not
      account data — no server round-trip needed). The script tag is
      deliberately *not* deferred and sits right after the header
      markup in `nav.php`, so a saved theme applies before most of
      the page renders instead of visibly flashing the default theme
      first.
      Verified with a `jsdom` test (selecting an era updates the CSS
      custom properties and injects the right font `<link>`;
      reloading with a saved choice re-applies it automatically;
      resetting to "Default theme" clears the overrides) and then
      visually, end to end, through real Chrome: used the DevTools
      Protocol directly (`--remote-debugging-port`, driven over a
      raw WebSocket from Node, since no higher-level browser tool is
      available here) to set `localStorage` on the actual running
      page, reload it, and screenshot the result — confirmed the
      1989 theme correctly swapped in a light-blue accent and the
      handwritten marker font.
      **Comparison research this was based on**: fetched
      tssongsorter.com (a similar Taylor Swift song-ranking site) and
      compared its scope against this project's — it includes ~376
      songs (covers, live versions, holiday songs, and features
      alongside the 12 albums/EPs) against this project's 254
      songs/334 recordings, though its own default-excluded count
      (107) lands close enough to this project's total that the
      "core discography" scope is actually similar; the gap is
      mostly the extra categories this project doesn't track at all
      yet. That — adding the missing song categories — and an audio-
      preview feature (their site plays a snippet per song; this one
      doesn't yet) are both still open, see the new backlog items
      below.

## Backlog / Ideas

- [ ] **Add the song categories missing from the catalogue**
      (covers, live versions, holiday songs, soundtrack
      contributions, features) — found via the tssongsorter.com
      comparison above. Needs research before any code: verify what
      actually exists against Wikipedia (this project's established
      sourcing standard), not just trust another site's list
      directly. Also a real scope question to settle first: this
      catalogue has so far meant "Taylor's own studio discography" —
      does a "feature" (a song that's primarily someone else's, with
      Taylor guesting) actually belong in a "Taylor Swift Catalogue,"
      or should that specific category stay out on purpose?
- [ ] **Audio preview snippets** on the Tournament matchup cards, so
      a visitor who doesn't remember a song can hear a clip before
      choosing — tssongsorter.com has this. The iTunes Search API
      (already used here for album artwork) also returns a 30-second
      `previewUrl` per track, but today's integration
      (`backend/artwork.php`) only looks up albums, not individual
      recordings. Would need a new per-recording lookup+cache
      (matching title + version, same pattern as artwork caching)
      and an `<audio>` + play button wired into `tournament.js`'s
      matchup cards.
- [ ] Label every "From the Vault" track (not just All Too Well)
      and consider a dedicated page for them, similar to
      `version.php`'s by-version-type browsing. User's own idea,
      raised and then explicitly deferred as "unnecessary for now"
      — don't build until asked. `album_tracks.edition = 'From the
      Vault'` already identifies every vault track if/when this
      gets picked up (already used for the vault-track count on
      `stats.php`), so no schema work would be needed, just display.
- [ ] Add official lyric videos as a fallback for songs that only
      have a lyric video and no full music video (currently they show
      nothing) — user's idea, explicitly deferred to later.
- [ ] Add any albums/bonus tracks released after *The Life of a
      Showgirl: The Encore* (Sept 2026) if and when they exist.

## Feature backlog (user-proposed, 2026-10-07)

User came up with a broad list of possible next features and picked
an order to tackle three of them: (1) documentation pages, (2) Song
Recommendations, (3) Catalogue Statistics Dashboard — **all three
are now done, see "Completed" above.** Everything else on the
original list (including parts not picked yet) is logged here for
later. Feasibility notes reflect the current stack: plain PHP/PDO +
MySQL, no JS anywhere yet, no user accounts, no framework.

Already done, not backlog: *Official Music Video Links* (item 14) —
`tracklist.php` already links every recording's video where one
exists, falling back to another version's video when a bonus/vault
track borrows one. *Song Recommendations* and the 4 documentation
pages are also done — see "Completed" above.

### Core interactive features
*Favourite Song Tournament* is done — see "Completed" above. Turned
out simpler than originally scoped here: a classic single-elimination
bracket (not a full pairwise-ranking convergence), which the user's
own spec made clear.
- [ ] Build Your Own Playlist — pick songs by hand (rather than
      generating from the Tournament) and reorder them, cap the
      track count, name it. Smaller than it looked originally: the
      storage, naming, saving, and viewer (`playlists.js` /
      `playlists.php`) already exist from the Tournament-to-playlist
      feature — what's actually left is a song-picker UI and
      drag-and-drop reordering, this project's first real case for
      that kind of interaction.

### Data & statistics
*Catalogue Statistics Dashboard* is done — see "Completed" above.
- [ ] Interactive Album Timeline — albums in release order with
      dates, each clickable through to its tracklist. No JS needed;
      basically a differently-sorted, differently-styled version of
      the existing homepage album grid.
- [ ] Song/Album Data Visualisations — charts comparing album sizes,
      release years, theme counts. Could stay JS-free with CSS-only
      bar charts for simple cases, but anything more chart-like
      (e.g. a timeline plot) would want a small charting library —
      this project's first external JS dependency.
- [ ] Song DNA / Profile — a visual "fingerprint" per song from its
      themes/mood/metadata, with two songs comparable side by side.
      Needs real visual design work; natural to build once a song
      detail page and the stats groundwork both exist.

### Discovery
- [ ] Enhanced Search — extend `search.php` to match writers/
      producers/artists too (not just song/album titles), and
      highlight the matched term in results. Builds directly on the
      existing search page and the songwriter/producer junction
      tables already in the schema.
- [ ] Advanced Filters — album, era, mood/theme, track number,
      original vs. Taylor's Version, collaborations. All filterable
      with data already in the schema (`version_type`,
      `recording_themes`, `album_tracks`); mainly a UI/query-builder
      problem, same GET-param pattern `moods.php` already uses for
      multi-select themes.
- [ ] Random Song / Random Album — "surprise me" links straight to a
      random tracklist or song. Trivial: `ORDER BY RAND() LIMIT 1`
      (or an app-level random pick) plus a redirect.
- [ ] Song Connections — surface shared themes/moods/album/writers
      between songs, beyond the theme-only similarity that Song
      Recommendations (now on `song.php`) already covers — e.g.
      shared writers/producers, or same-album relationships.

### External media
- [ ] Music Video Explorer — a dedicated page listing every song
      with an official music video, filterable/searchable. All the
      data (`music_video_url`) already exists from the earlier
      music-video rollout; this is a new filtered view over it, no
      new data needed.

### Personalisation
*Favourite Songs* is done, including the star button on every page
that shows a song title — see "Completed" above. User confirmed the
real-browser click-test too: favourites set in one session were
still there at the start of the next.
- [ ] Personal Ratings — rate songs, see personal ratings, pairs
      naturally with the tournament feature. Same `localStorage`
      approach as Favourite Songs.
- [ ] Personal Album Rankings — rank whole albums, same storage
      approach as the above two.
- [ ] Shareable Results — let a tournament result be shared via a
      URL rather than requiring an account (e.g. encode the champion
      + ranking as a compact query-string param). Now unblocked —
      the Tournament itself is done.

### Quality / portfolio features
*Accessibility Pass* and *Responsive Design pass* are done for now
— see "Completed" above (found a real nav-overflow bug affecting
every page, fixed heading hierarchy, added screen-reader
announcements for JS-driven updates). Worth a real visual check on
an actual phone at some point, since this session's fixes were
verified by code review rather than a live render.
- [ ] Dark Mode toggle — manual light/dark switch that remembers the
      choice, on top of the `prefers-color-scheme` support already
      in `style.css`. Needs a small bit of JS plus `localStorage`
      for the remembered preference.
- [ ] Loading/Error/Empty States — handle missing data, broken
      external links (iTunes artwork, YouTube videos), empty search
      results, slow loads gracefully. An audit/polish pass across
      existing pages rather than new functionality.
- [ ] Performance Optimisation — image lazy-loading, avoiding
      loading the whole catalogue at once, mobile performance
      checks. Low urgency at the current catalogue size/traffic, but
      cheap wins exist now (e.g. `loading="lazy"` on album art).

### Content / documentation
All 5 items here (Image Credits & Licences, About the Project, Data
Sources, Privacy, Clear Unofficial Branding) are done — see the
"Completed" section above.

## New direction, 2026-10-23: accounts + community-contributed data

Three items the user added, logged together because they genuinely
interconnect. This is a real shift, not just three more features —
every piece of personalisation built so far (Favourites, Tournament
progress, Playlists) was deliberately designed around *zero*
accounts and *zero* server-side user data, specifically to avoid
needing auth, sessions, or cookies (see `privacy.php`, which
currently promises exactly that). All three items below push
against that premise in different ways, so the usual "no new
infrastructure needed" framing doesn't really apply here — flagging
that honestly rather than understating the lift.

- [x] **User accounts + login — first milestone done**, see
      "Completed" above: registration, login, logout, a `users`
      table, hashed passwords, CSRF-protected forms, login status in
      the nav everywhere. Deliberately scoped to just that.
      Syncing Favourites/Tournament results/Playlists to an account
      is now done too — see the cross-device sync entry below.
      **Still open, not yet started**: rate-limiting/lockout on
      repeated failed logins; a "forgot password" flow; email
      verification. The DB-root-password-rotation and non-root-DB-user
      items under "Deferred until going public" are no longer
      deferrable now that real user data (emails, password hashes)
      exists in this database.
- [x] **Cross-device sync for Favourites/Playlists/Tournament
      results.** Logged in, these three are stored under your
      account instead of (or alongside) localStorage, so they follow
      you to any device. Scope decisions, in order of how much they
      matter:
      1. **Only the finished Tournament *result* syncs, never the
      in-progress bracket.** The live bracket (current matchup, undo
      history) stays local to whichever browser you're playing in,
      logged in or not — syncing a mid-play nested undo stack across
      devices is a much bigger problem for little real benefit over
      syncing the final ranked outcome, which is what was actually
      asked for.
      2. **First-login import, not continuous merge.** The first time
      you log in on a device with existing local data and your
      account has none of that type yet, it's copied up once; after
      that the account is authoritative and local-only data on any
      device is left alone, untouched. No multi-device conflict
      resolution was built (e.g. device A has playlist X, device B
      has playlist Y, which wins) — deliberately out of scope, flagged
      honestly rather than attempted half-way.
      3. **This is the first client-server fetch/AJAX in the
      codebase** — confirmed zero `fetch`/AJAX calls existed anywhere
      before this. Every previous feature was either a full-page PHP
      form or pure localStorage JS.
      New tables (`sql/0007_add_user_sync.sql`, folded into
      `schema.sql`): `user_favourites` (user_id+song_id);
      `user_playlists`/`user_playlist_songs` (ordered by `position`,
      by `song_id` — title/album/duration are looked up live from the
      catalogue at render time, never snapshotted); `tournament_results`/
      `tournament_result_rankings` (by `recording_id`, not `song_id` —
      the Tournament pits specific recordings against each other, and
      the planned stats feature needs that precision for albums).
      New `backend/api/` directory: `_bootstrap.php` (shared
      login-required + CSRF-checked + DB-connected setup for every
      endpoint), `favourites.php` (list/add/remove/import),
      `playlists.php` (list/create/delete/remove_song/import, every
      response returning the full current playlist list so the
      client just re-renders rather than tracking its own merge
      logic), `tournament_results.php` (one POST per finished run).
      `nav.php` now exposes `window.TS_LOGGED_IN`/`window.TS_CSRF_TOKEN`
      for the JS to read.
      `favorites.js`/`playlists.js` rewritten to switch between
      localStorage and server calls based on `TS_LOGGED_IN`, keeping
      the same public interface (`TSPlaylists.readAll/save/remove/
      removeSongAt`) so other code didn't need to change — though
      every method now returns a Promise even on the localStorage
      path, since going through the server made at least some of
      them genuinely async; `playlists_view.js` and the relevant part
      of `tournament.js` updated to chain off that. `tournament.js`
      gained a `syncedToServer` flag (deliberately outside the
      undo-tracked snapshot fields, so undo can't revert it) so a
      finished run is only ever POSTed once.
      Updated the "stored only in this browser" copy on
      `favourites.php`/`playlists.php`/`tournament.php` and the
      relevant `privacy.php` bullets to be accurate for both logged-in
      and logged-out visitors, rather than leaving the old
      logged-out-only claim in place.
      Verified live with `curl` against the real database: favourites
      list/add/list/remove/import/import-again (second import
      correctly imports 0, proving the "only when server-side empty"
      guard works); playlists create/list/remove_song (confirmed
      position renumbering after a removal) /import/import-again;
      a second test user's attempt to delete the first user's
      playlist correctly did nothing (ownership check scoped the
      `DELETE` to `WHERE ... AND user_id = :userId`, confirmed by
      re-querying the DB directly); a tournament result submission
      correctly wrote one `tournament_results` row plus ranked
      `tournament_result_rankings` rows. All test users/playlists/
      results deleted afterward.
- [x] **Collective theme tagging — first milestone done.** Registered
      users only (resolved the "real account vs anonymous" question
      from below in favor of requiring login — simpler, and
      consistent with tying this to accounts rather than localStorage).
      New table `user_song_themes` (`sql/0006_add_user_song_themes.sql`,
      folded into `schema.sql`): `user_id` + `song_id` + `theme_id` as
      the primary key, so a tag is distinguishable from curated data
      and a "vote count" is just how many distinct users applied the
      same theme to the same song. Deliberately additive and separate
      from `recording_themes` — it does **not** feed the Moods
      playlist builder or the "Similar songs" algorithm, so the
      curated recommendation data stays clean; this was the product
      decision flagged below ("visibly separate community tags
      section") rather than a vote-threshold-to-merge model.
      On `song.php`: curator themes and a new "Community tags" line
      (name + vote count) display separately; logged-in users get a
      form to apply an existing theme or suggest a new one; logged-out
      users see a login prompt instead of the form.
      **User caught two real gaps before this was built, not after**
      (unlike the accounts-milestone gaps, found proactively this
      time): a new theme name needed (1) a profanity/slur filter, and
      (2) protection against the list filling up with near-duplicate
      misspellings ("heartbreak", "Heartbreak", "heart break",
      "hartbreak" all becoming separate rows). Built both into
      `backend/helpers.php`:
      `theme_name_contains_blocked_word()` checks whole tokens (plus
      a squashed-string check for spaced-out evasion like "r a p e")
      against `backend/profanity_blocklist.php` — never a substring
      scan, so a blocked word inside an unrelated word (e.g. "rape"
      inside "grape") is never a false positive (the "Scunthorpe
      problem"). `find_similar_theme()` does two passes: a
      punctuation/case/whitespace-stripped exact match auto-reuses
      the existing theme with no prompt (e.g. "Break Up" silently
      becomes "breakup"), and a Levenshtein check scaled to word
      length catches likely typos and asks "Did you mean X?" before
      creating a near-duplicate, with an explicit "no, mine is
      different" override.
      Verified live with `curl`: "rape" blocked, "grapevine" correctly
      *not* blocked (confirms no Scunthorpe false positive); "Break
      Up" silently reused the existing "breakup" theme; "acceptence"
      correctly triggered "Did you mean 'acceptance'?"; explicitly
      confirming "mine is different" created a genuine new theme.
      Test users/tags/theme deleted from the database afterward.
      Updated `privacy.php` to honestly describe this (tagging is
      tied to your account, not anonymous; theme suggestions are
      filtered) per the promise it already made to update "plainly"
      once this shipped.
      **Deliberately not built in this milestone**: no moderation/
      review queue before a tag goes live (flagging that honestly —
      there's no review step between submission and a tag being
      public); no way to remove your own tag; no rate-limiting on
      how many tags one account can add.
- [x] **Community Tournament stats — done.** Built on top of the
      cross-device sync work above, which already landed the
      `tournament_results`/`tournament_result_rankings` tables and
      the account-tied (not anonymous) submission — the abuse
      question flagged below is the same one that milestone already
      addressed by requiring login.
      New section on `stats.php` ("Community Tournament results"):
      "Most popular recordings" and "Most popular albums", ranked by
      average placement across every completed run. Worked at
      recording granularity, same as the Tournament itself (an
      original and its Taylor's Version are ranked separately, not
      merged) — consistent with the reasoning in `tournament.php`
      for why recordings, not songs, are the entrants. Average
      placement is directly comparable across different users' runs
      because every run covers the exact same full catalogue (no
      song-subset option), so there's no "smaller bracket inflates
      the ranking" skew to correct for. Albums roll up every member
      recording's individual rank. An explicit small-sample caveat
      shows below 5 completed runs, and an honest empty state shows
      before anyone's finished one.
      Extracted the recording-display-title logic (bare title for
      the original, "(Taylor's Version)"-style suffix for everything
      else, the hardcoded "All Too Well (10 Minute Version)..."
      special case) out of `tournament.php` into a new
      `recording_display_title()` in `backend/helpers.php`, since
      the stats page needed the exact same formatting and copying
      the special-cased hardcode a second time would've been a real
      duplication, not just a convenience.
      Updated `privacy.php`'s forward-looking promise (from the
      accounts milestone) into a plain statement of what's now true:
      your own result feeds the aggregate, but the page only ever
      shows averages/counts, never whose results they came from.
      Verified live: registered 3 test users, submitted a tournament
      result from each via the real API, confirmed `stats.php`
      correctly computed average placement per recording and per
      album (including the Taylor's Version suffix rendering
      correctly) and showed the right run count and small-sample
      caveat; also checked the zero-results empty state separately.
      All test data deleted afterward.

**All three shipped, in the order originally suggested**: accounts
first, then theme tagging and Tournament stats on top of it, so both
ended up tied to real accounts rather than anonymous/abuse-prone from
the start. Cross-device sync for Favourites/Playlists/Tournament
results (not part of the original three, added when the user asked
for it directly) landed in between, and the Tournament stats table it
introduced is what the stats feature is actually built on.
