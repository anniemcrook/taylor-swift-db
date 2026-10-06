-- Seed data: Midnights (2022), covering every officially released
-- edition's tracks in one album row, tagged via `edition`:
--   NULL              = standard edition (13 tracks)
--   '3am Edition'      = 7 bonus tracks, released same day (Oct 21, 2022)
--   'Til Dawn Edition'  = 3 more additions released May 26, 2023:
--                         "Hits Different" (new song, originally a
--                         Lavender/Japan CD-exclusive bonus track from
--                         2022), plus new extended/remix RECORDINGS of
--                         two existing songs ("Snow on the Beach" with
--                         more Lana Del Rey, "Karma" feat. Ice Spice)
--   'Late Night Edition' = "You're Losing Me (From the Vault)", a CD-
--                         exclusive bonus released the same day as Til
--                         Dawn but on a separate physical edition
-- No Taylor's Version exists for this album.
--
-- Skipped: the Lavender/Japan CD-exclusive "strings remix" of "You're
-- on Your Own, Kid" and "piano remix" of "Sweet Nothing" — pure remix
-- bonus tracks on a niche regional release, out of scope for now.
--
-- DATA-QUALITY NOTE (per the lesson from evermore): the standard
-- edition's 13 lengths sum to exactly 44:02, matching the album's
-- stated total exactly. The 3am Edition's 7 additional lengths bring
-- the running total to exactly 69:20, also an exact match. For the
-- Til Dawn Edition's 3 additions, the individual lengths were
-- cross-checked against Apple Music's rounded "23 songs, 1h20m"
-- total (summing to 80:25) rather than trusting the initial bulk
-- fetch's stated 81:26 figure, which — as with reputation earlier —
-- appears to be a minor infobox rounding/data-entry error.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Midnights', '2022-10-21', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @antonoff := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);
SET @dessner  := (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner' LIMIT 1);
SET @alwyn    := (SELECT artist_id FROM artists WHERE name = 'Joe Alwyn' LIMIT 1);
-- Sounwave already exists (created in sql/2019_lover.sql for "London Boy").
SET @sounwave := (SELECT artist_id FROM artists WHERE name = 'Sounwave' LIMIT 1);

INSERT INTO artists (name) VALUES ('Zoë Kravitz');
SET @kravitz := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Jahaan Sweet');
SET @sweet := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Sam Dew');
SET @dew := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Braxton Cook');
SET @cook := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Lana Del Rey');
SET @delrey := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Keanu Beats');
SET @keanubeats := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Ice Spice');
SET @icespice := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('RiotUSA');
SET @riotusa := LAST_INSERT_ID();

-- 1. Lavender Haze
INSERT INTO songs (title, original_release_year) VALUES ('Lavender Haze', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 202);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @kravitz), (@rec, @sounwave), (@rec, @sweet), (@rec, @dew);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @sweet), (@rec, @cook);

-- 2. Maroon
INSERT INTO songs (title, original_release_year) VALUES ('Maroon', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 218);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 3. Anti-Hero
INSERT INTO songs (title, original_release_year) VALUES ('Anti-Hero', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 200);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 4. Snow on the Beach (feat. Lana Del Rey)
INSERT INTO songs (title, original_release_year) VALUES ('Snow on the Beach', 2022);
SET @song := LAST_INSERT_ID();
SET @song_snow := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 256);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @delrey), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 5. You're on Your Own, Kid
INSERT INTO songs (title, original_release_year) VALUES ("You're on Your Own, Kid", 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 194);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 6. Midnight Rain
INSERT INTO songs (title, original_release_year) VALUES ('Midnight Rain', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 174);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 7. Question...?
INSERT INTO songs (title, original_release_year) VALUES ('Question...?', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 210);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 8. Vigilante Shit
INSERT INTO songs (title, original_release_year) VALUES ('Vigilante Shit', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 164);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 9. Bejeweled
INSERT INTO songs (title, original_release_year) VALUES ('Bejeweled', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 194);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 10. Labyrinth
INSERT INTO songs (title, original_release_year) VALUES ('Labyrinth', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 247);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 11. Karma
INSERT INTO songs (title, original_release_year) VALUES ('Karma', 2022);
SET @song := LAST_INSERT_ID();
SET @song_karma := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 204);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @sweet), (@rec, @keanubeats);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @keanubeats), (@rec, @sweet);

-- 12. Sweet Nothing
INSERT INTO songs (title, original_release_year) VALUES ('Sweet Nothing', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 188);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 13. Mastermind
INSERT INTO songs (title, original_release_year) VALUES ('Mastermind', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 191);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 14. The Great War (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('The Great War', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 14, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 15. Bigger Than the Whole Sky (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Bigger Than the Whole Sky', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 218);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 16. Paris (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Paris', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 196);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 17. High Infidelity (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('High Infidelity', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 18. Glitch (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Glitch', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 148);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @dew);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave);

-- 19. Would've, Could've, Should've (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ("Would've, Could've, Should've", 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 260);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 20. Dear Reader (3am Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Dear Reader', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 225);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, '3am Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 21. Hits Different (Til Dawn Edition) — originally a 2022
-- Lavender/Japan CD-exclusive bonus track, brought to wide release
-- via the Til Dawn Edition in 2023.
INSERT INTO songs (title, original_release_year) VALUES ('Hits Different', 2022);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'Til Dawn Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @dessner);

-- 22. Snow on the Beach (feat. More Lana Del Rey) (Til Dawn Edition)
-- — same song as track 4, a new extended-vocal recording.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_snow, 'remix', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 22, 'Til Dawn Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @delrey), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 23. Karma (feat. Ice Spice) (Til Dawn Edition) — same song as
-- track 11, a new remix recording with an added rap verse.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_karma, 'remix', 201);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 23, 'Til Dawn Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @sweet), (@rec, @keanubeats), (@rec, @icespice), (@rec, @riotusa);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @sounwave), (@rec, @keanubeats), (@rec, @sweet);

-- 24. You're Losing Me (From the Vault) (Late Night Edition) —
-- written Dec 2021 during the Midnights sessions, held back, then
-- released as a bonus track / standalone single in Nov 2023.
INSERT INTO songs (title, original_release_year) VALUES ("You're Losing Me", 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 278);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 24, 'Late Night Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
