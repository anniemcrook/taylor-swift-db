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
      proof-of-concept; populating the rest of the catalog (likely
      60-100+ videos across all 16 albums, each needing the same
      oEmbed verification) is a large pending effort — see backlog.

## Backlog / Ideas

- [ ] Populate `recordings.music_video_url` across the rest of the
      catalog (only "Love Story"/"Love Story (Taylor's Version)" done
      so far) — verify every URL via YouTube oEmbed's `author_url`
      before use, same as above.
- [ ] Commit a `sql/schema.sql` dump so the schema is reproducible
      from a clean checkout (currently only exists live in MySQL).
- [ ] Add any albums/bonus tracks released after *The Life of a
      Showgirl: The Encore* (Sept 2026) if and when they exist.
- [ ] Basic styling/CSS pass on the HTML output (everything is still
      unstyled browser-default HTML).
