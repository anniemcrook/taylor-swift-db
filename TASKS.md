# Project Tasks

Running log of what's done and what's left on the Taylor Swift DB project.
Check this at the start of every session before starting new work.

## High Priority

- [ ] Before making this repo public: rotate the MySQL `root` password
      that was briefly hardcoded in `backend/tracklist.php` and
      `backend/index.php` during early development. It was never
      committed to git, but was live on disk — rotate it as a
      precaution before treating it as safe.
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

## Backlog / Ideas

- [ ] Commit a `sql/schema.sql` dump so the schema is reproducible
      from a clean checkout (currently only exists live in MySQL).
- [ ] Add more albums/eras beyond *1989*.
- [ ] Song comparison view (e.g. original vs Taylor's Version
      side-by-side: duration, songwriters, producers).
- [ ] Basic styling/CSS pass on the HTML output.
