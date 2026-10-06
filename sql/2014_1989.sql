-- Seed data: 1989 (2014 standard/deluxe edition, 16 tracks). This
-- album's data (along with its Taylor's Version counterpart,
-- sql/2023_1989_taylors_version.sql) was the original pre-existing
-- data this project started from, before the sql/ seed-file
-- convention existed — this file reconstructs it from the live
-- database so the schema is reproducible from a clean checkout (see
-- sql/schema.sql), matching the current data exactly, gaps and all
-- (several Taylor's Version tracks in the companion file have no
-- producer credit recorded at all — that's pre-existing, not a new
-- omission).
--
-- This is the first dated seed file to need Taylor Swift, Max Martin,
-- Shellback, and Nathan Chapman — all bootstrapped in
-- sql/0000_core_artists.sql, since no script ever inserts them
-- fresh. This file is also the first to need Jack Antonoff (1989 was
-- his first-ever collaboration with Taylor), so it creates him.

INSERT INTO albums (title, release_date, album_type)
VALUES ('1989', '2014-10-27', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @martin   := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback:= (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);
SET @chapman  := (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman' LIMIT 1);

INSERT INTO artists (name) VALUES ('Ryan Tedder');
SET @tedder := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Noel Zancanella');
SET @zancanella := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Jack Antonoff');
SET @antonoff := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Imogen Heap');
SET @heap := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Ali Payami');
SET @payami := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Mattman & Robin');
SET @mattman := LAST_INSERT_ID();

-- 1. Welcome to New York
INSERT INTO songs (title, original_release_year) VALUES ('Welcome to New York', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 210);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder), (@rec, @zancanella);

-- 2. Blank Space
INSERT INTO songs (title, original_release_year) VALUES ('Blank Space', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 3. Style
INSERT INTO songs (title, original_release_year) VALUES ('Style', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @payami);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 4. Out of the Woods
INSERT INTO songs (title, original_release_year) VALUES ('Out of the Woods', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @antonoff);

-- 5. All You Had to Do Was Stay
INSERT INTO songs (title, original_release_year) VALUES ('All You Had to Do Was Stay', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 193);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @mattman);

-- 6. Shake It Off
INSERT INTO songs (title, original_release_year) VALUES ('Shake It Off', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 219);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 7. I Wish You Would
INSERT INTO songs (title, original_release_year) VALUES ('I Wish You Would', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 207);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @antonoff);

-- 8. Bad Blood
INSERT INTO songs (title, original_release_year) VALUES ('Bad Blood', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 9. Wildest Dreams
INSERT INTO songs (title, original_release_year) VALUES ('Wildest Dreams', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 10. How You Get the Girl
INSERT INTO songs (title, original_release_year) VALUES ('How You Get the Girl', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 247);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 11. This Love
INSERT INTO songs (title, original_release_year) VALUES ('This Love', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 250);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 12. I Know Places
INSERT INTO songs (title, original_release_year) VALUES ('I Know Places', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 195);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder), (@rec, @zancanella);

-- 13. Clean
INSERT INTO songs (title, original_release_year) VALUES ('Clean', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 271);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @heap);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @heap);

-- 14. Wonderland
INSERT INTO songs (title, original_release_year) VALUES ('Wonderland', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 15. You Are in Love
INSERT INTO songs (title, original_release_year) VALUES ('You Are in Love', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 267);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 16. New Romantics
INSERT INTO songs (title, original_release_year) VALUES ('New Romantics', 2014);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 16);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);
