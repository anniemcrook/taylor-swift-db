-- Seed data: Speak Now (Taylor's Version) (2023), 22 tracks.
-- Run AFTER sql/2010_speak_now.sql — tracks 1-16 reuse the same
-- `songs` rows as the original standard + deluxe tracks (same
-- composition, new recording), looked up by title. Note: the deluxe
-- edition's acoustic/pop-mix alternate recordings and "If This Was a
-- Movie" were NOT carried over to Taylor's Version. Tracks 17-22 are
-- six new "From the Vault" songs, never previously released.
-- Credits/durations per Wikipedia, cross-checked against the album's
-- official 104:33 total runtime.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Speak Now (Taylor''s Version)', '2023-07-07', 'taylors_version');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @rowe     := (SELECT artist_id FROM artists WHERE name = 'Christopher Rowe' LIMIT 1);
SET @dessner  := (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner' LIMIT 1);
SET @antonoff := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);

-- Tracks 1-16: re-recordings of songs already in `songs`, all written
-- solely by Taylor Swift, produced by Swift + Christopher Rowe.

SET @song := (SELECT song_id FROM songs WHERE title = 'Mine' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Sparks Fly' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 261);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Back to December' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 294);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Speak Now' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 242);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Dear John' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 405);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Mean' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'The Story of Us' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 267);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Never Grow Up' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 292);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Enchanted' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 353);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Better than Revenge' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Innocent' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 301);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Haunted' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Last Kiss' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 369);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Long Live' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 317);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 15-16: from the Deluxe Edition
SET @song := (SELECT song_id FROM songs WHERE title = 'Ours' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

SET @song := (SELECT song_id FROM songs WHERE title = 'Superman' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 274);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 17-22: "From the Vault" — previously unreleased songs, all written
-- solely by Taylor Swift.

INSERT INTO songs (title, original_release_year) VALUES ('Electric Touch', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 266);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

INSERT INTO songs (title, original_release_year) VALUES ('When Emma Falls in Love', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 252);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

INSERT INTO songs (title, original_release_year) VALUES ('I Can See You', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 273);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

INSERT INTO songs (title, original_release_year) VALUES ('Castles Crumbling', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 306);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

INSERT INTO songs (title, original_release_year) VALUES ('Foolish One', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 311);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

INSERT INTO songs (title, original_release_year) VALUES ('Timeless', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 321);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 22, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
