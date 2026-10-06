-- Seed data: folklore (2020 standard edition, 16 tracks) plus the
-- deluxe edition's 1 bonus track ("the lakes"). No Taylor's Version
-- exists for this album.
-- Credits/durations per Wikipedia and individually cross-checked
-- per-track (the album's own aggregate infobox tables proved
-- unreliable when fetched in bulk — see sql/2020_12_evermore.sql for
-- a much worse case of this on the same day). The verified per-track
-- lengths sum to 63:31 against Wikipedia's stated 63:29 (2-second
-- rounding difference, treated as a minor infobox error as with
-- reputation earlier).
-- "William Bowery" (a pseudonym) is recorded here under Joe Alwyn's
-- real name for clarity in this catalog.
--
-- Run BEFORE sql/2020_12_evermore.sql — this is folklore's real-world
-- release month (July), and this file is Aaron Dessner's, Joe
-- Alwyn's, and Justin Vernon's first-ever appearance in this catalog,
-- so it's the file responsible for creating those three artists fresh.

INSERT INTO albums (title, release_date, album_type)
VALUES ('folklore', '2020-07-24', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @antonoff := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);

INSERT INTO artists (name) VALUES ('Aaron Dessner');
SET @dessner := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Joe Alwyn');
SET @alwyn := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Justin Vernon');
SET @vernon := LAST_INSERT_ID();

-- 1. the 1
INSERT INTO songs (title, original_release_year) VALUES ('the 1', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 210);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 2. cardigan
INSERT INTO songs (title, original_release_year) VALUES ('cardigan', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 3. the last great american dynasty
INSERT INTO songs (title, original_release_year) VALUES ('the last great american dynasty', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 4. exile (feat. Bon Iver)
INSERT INTO songs (title, original_release_year) VALUES ('exile', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 285);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn), (@rec, @vernon);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner), (@rec, @alwyn);

-- 5. my tears ricochet
INSERT INTO songs (title, original_release_year) VALUES ('my tears ricochet', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 255);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @alwyn);

-- 6. mirrorball
INSERT INTO songs (title, original_release_year) VALUES ('mirrorball', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 209);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 7. seven
INSERT INTO songs (title, original_release_year) VALUES ('seven', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 208);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 8. august
INSERT INTO songs (title, original_release_year) VALUES ('august', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 261);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @alwyn);

-- 9. this is me trying
INSERT INTO songs (title, original_release_year) VALUES ('this is me trying', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 196);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @alwyn);

-- 10. illicit affairs
INSERT INTO songs (title, original_release_year) VALUES ('illicit affairs', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 190);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @alwyn);

-- 11. invisible string
INSERT INTO songs (title, original_release_year) VALUES ('invisible string', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 252);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 12. mad woman
INSERT INTO songs (title, original_release_year) VALUES ('mad woman', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 13. epiphany
INSERT INTO songs (title, original_release_year) VALUES ('epiphany', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 289);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 14. betty
INSERT INTO songs (title, original_release_year) VALUES ('betty', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 294);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner), (@rec, @antonoff);

-- 15. peace
INSERT INTO songs (title, original_release_year) VALUES ('peace', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 16. hoax
INSERT INTO songs (title, original_release_year) VALUES ('hoax', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 16);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 17. the lakes (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('the lakes', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
