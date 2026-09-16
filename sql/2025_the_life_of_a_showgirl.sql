-- Seed data: The Life of a Showgirl (2025), 12 tracks. This is
-- Taylor's first album made with only one production team throughout
-- (Max Martin and Shellback, no other collaborators), so writer and
-- producer credits are uniform across the whole album except
-- "Father Figure", which carries an added interpolation credit for
-- George Michael.
--
-- Skipped: the various CD-exclusive variant editions' acoustic
-- re-recordings and voice-memo/demo versions of existing songs (e.g.
-- "Opalite (Life Is A Song Acoustic Version)", "Elizabeth Taylor
-- (Original Songwriting Voice Memo)") — these are alternate
-- recordings of songs already captured below, not new songs, and are
-- out of scope for now (same treatment as the Lavender/Japan
-- remix-only bonus tracks skipped on Fearless and Midnights).
--
-- Durations sum to exactly 41:40, matching the album's stated total
-- exactly.

INSERT INTO albums (title, release_date, album_type)
VALUES ('The Life of a Showgirl', '2025-10-03', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor    := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @martin    := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);

INSERT INTO artists (name) VALUES ('George Michael');
SET @gmichael := LAST_INSERT_ID();

-- 1. The Fate of Ophelia
INSERT INTO songs (title, original_release_year) VALUES ('The Fate of Ophelia', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 226);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 2. Elizabeth Taylor
INSERT INTO songs (title, original_release_year) VALUES ('Elizabeth Taylor', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 208);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 3. Opalite
INSERT INTO songs (title, original_release_year) VALUES ('Opalite', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 4. Father Figure — interpolates George Michael's 1987 song of the
-- same name, hence his added writing credit here.
INSERT INTO songs (title, original_release_year) VALUES ('Father Figure', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 212);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @gmichael);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 5. Eldest Daughter
INSERT INTO songs (title, original_release_year) VALUES ('Eldest Daughter', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 246);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 6. Ruin the Friendship
INSERT INTO songs (title, original_release_year) VALUES ('Ruin the Friendship', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 7. Actually Romantic
INSERT INTO songs (title, original_release_year) VALUES ('Actually Romantic', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 163);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 8. Wi$h Li$t
INSERT INTO songs (title, original_release_year) VALUES ('Wi$h Li$t', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 207);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 9. Wood
INSERT INTO songs (title, original_release_year) VALUES ('Wood', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 150);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 10. Cancelled!
INSERT INTO songs (title, original_release_year) VALUES ('Cancelled!', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 11. Honey
INSERT INTO songs (title, original_release_year) VALUES ('Honey', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 181);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 12. The Life of a Showgirl (feat. Sabrina Carpenter)
INSERT INTO songs (title, original_release_year) VALUES ('The Life of a Showgirl', 2025);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 241);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
