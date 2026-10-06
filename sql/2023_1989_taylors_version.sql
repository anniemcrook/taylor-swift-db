-- Seed data: 1989 (Taylor's Version) (2023, 21 tracks: the 16
-- original-era songs plus 5 From the Vault tracks). Reconstructed
-- from the live database — see the note at the top of
-- sql/2014_1989.sql for why this file exists and what "matching
-- exactly, gaps and all" means. In particular: most of these
-- re-recorded tracks have NO producer credit recorded at all in the
-- source data (only a handful do), and "Is It Over Now?" has no
-- songwriter credit recorded either — these aren't new gaps
-- introduced here, they're faithfully reproduced from what the
-- database already contained.
--
-- Run after sql/2021_fearless_taylors_version.sql, which creates
-- Christopher Rowe fresh — this file only looks him up.

INSERT INTO albums (title, release_date, album_type)
VALUES ('1989 (Taylor''s Version)', '2023-10-27', 'taylors_version');
SET @album_id := LAST_INSERT_ID();

SET @taylor     := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @martin     := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback  := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);
SET @antonoff   := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);
SET @tedder     := (SELECT artist_id FROM artists WHERE name = 'Ryan Tedder' LIMIT 1);
SET @zancanella := (SELECT artist_id FROM artists WHERE name = 'Noel Zancanella' LIMIT 1);
SET @heap       := (SELECT artist_id FROM artists WHERE name = 'Imogen Heap' LIMIT 1);
SET @payami     := (SELECT artist_id FROM artists WHERE name = 'Ali Payami' LIMIT 1);
SET @rowe       := (SELECT artist_id FROM artists WHERE name = 'Christopher Rowe' LIMIT 1);

INSERT INTO artists (name) VALUES ('Patrik Berger');
SET @berger := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Diane Warren');
SET @warren := LAST_INSERT_ID();

-- 1. Welcome to New York
SET @song := (SELECT song_id FROM songs WHERE title = 'Welcome to New York' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 212);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder), (@rec, @zancanella);

-- 2. Blank Space (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Blank Space' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 3. Style (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Style' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @payami);

-- 4. Out of the Woods (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Out of the Woods' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 5. All You Had to Do Was Stay (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'All You Had to Do Was Stay' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 193);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin);

-- 6. Shake It Off (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Shake It Off' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 219);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 7. I Wish You Would (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'I Wish You Would' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 207);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 8. Bad Blood (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Bad Blood' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 9. Wildest Dreams (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Wildest Dreams' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 10. How You Get the Girl
SET @song := (SELECT song_id FROM songs WHERE title = 'How You Get the Girl' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 247);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @rowe);

-- 11. This Love (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'This Love' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 250);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);

-- 12. I Know Places (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'I Know Places' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 195);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tedder);

-- 13. Clean (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Clean' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 270);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @heap);

-- 14. Wonderland (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'Wonderland' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 15. You Are in Love (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'You Are in Love' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 267);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 16. New Romantics (no producer credit recorded)
SET @song := (SELECT song_id FROM songs WHERE title = 'New Romantics' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 16);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);

-- 17-21: "From the Vault" — previously unreleased songs.

-- 17. Slut!
INSERT INTO songs (title, original_release_year) VALUES ('Slut!', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 180);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @berger);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @berger);

-- 18. Say Don't Go (no producer credit recorded)
INSERT INTO songs (title, original_release_year) VALUES ("Say Don't Go", 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 279);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @warren);

-- 19. Now That We Don't Talk
INSERT INTO songs (title, original_release_year) VALUES ("Now That We Don't Talk", 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 146);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 20. Suburban Legends
INSERT INTO songs (title, original_release_year) VALUES ('Suburban Legends', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 171);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 21. Is It Over Now? (no songwriter credit recorded beyond the
-- producer; faithfully reproduced as-is)
INSERT INTO songs (title, original_release_year) VALUES ('Is It Over Now?', 2023);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 229);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'From the Vault');
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @antonoff);
