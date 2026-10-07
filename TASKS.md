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
- [ ] Decide on a real (non-root) MySQL user with limited privileges
      for the app to connect as, instead of `root`.

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

## Backlog / Ideas

- [ ] Populate themes/moods across the rest of the catalog (only the
      Fearless era done so far).

- [ ] Add official lyric videos as a fallback for songs that only
      have a lyric video and no full music video (currently they show
      nothing) — user's idea, explicitly deferred to later.
- [ ] Add any albums/bonus tracks released after *The Life of a
      Showgirl: The Encore* (Sept 2026) if and when they exist.
