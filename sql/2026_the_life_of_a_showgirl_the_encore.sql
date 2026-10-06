-- Seed data: "The Life of a Showgirl: The Encore" (2026-09-25), the
-- deluxe reissue of The Life of a Showgirl adding 4 new bonus tracks,
-- tagged edition='The Encore' on the existing album row. All 4 are
-- new songs (not re-recordings), written and produced by the same
-- trio as the rest of the album (Taylor Swift, Max Martin, Shellback).
--
-- Durations sum to 14:01 for the 4 bonus tracks; combined with the
-- original 12 tracks' 41:40, that's 55:41 total, matching Apple
-- Music's independently-confirmed "~55 minutes" for the full 16-track
-- Encore edition.

SET @album_id := (SELECT album_id FROM albums WHERE title = 'The Life of a Showgirl' LIMIT 1);
SET @taylor    := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @martin    := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);

-- 13. Patient Zero
INSERT INTO songs (title, original_release_year) VALUES ('Patient Zero', 2026);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 226);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 13, 'The Encore');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 14. Cleveland!
INSERT INTO songs (title, original_release_year) VALUES ('Cleveland!', 2026);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 206);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 14, 'The Encore');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 15. Pink Clouding
INSERT INTO songs (title, original_release_year) VALUES ('Pink Clouding', 2026);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 190);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, 'The Encore');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 16. Babylon
INSERT INTO songs (title, original_release_year) VALUES ('Babylon', 2026);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 219);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'The Encore');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
