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

## Backlog / Ideas

- [ ] Commit a `sql/schema.sql` dump so the schema is reproducible
      from a clean checkout (currently only exists live in MySQL).
- [ ] Add more albums/eras, going in chronological order. Next up:
      *Speak Now* / *Speak Now (Taylor's Version)*, then *Red*,
      *reputation*, *Lover*, *folklore*, *evermore*, *Midnights*,
      and beyond.
- [ ] Song comparison view (e.g. original vs Taylor's Version
      side-by-side: duration, songwriters, producers).
- [ ] Basic styling/CSS pass on the HTML output.
