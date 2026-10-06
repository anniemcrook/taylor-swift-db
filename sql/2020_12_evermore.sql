-- Seed data: evermore (2020 standard edition, 15 tracks) plus the
-- deluxe edition's 2 bonus tracks. No Taylor's Version exists for this
-- album. Run after sql/2020_07_folklore.sql (reuses Aaron Dessner,
-- Joe Alwyn, and Justin Vernon, all added there).
--
-- IMPORTANT DATA NOTE: the first bulk fetch of this album's Wikipedia
-- track listing gave badly wrong lengths for several tracks (e.g.
-- "Cowboy like Me" as 3:56 instead of the actual 4:35, "Coney Island"
-- as 3:56 instead of 4:35, "Marjorie" as 4:07 instead of 4:17,
-- "Closure" as 3:31 instead of 3:00, "Long Story Short" as 3:15
-- instead of 3:35). This was caught by summing the initial 15 lengths
-- (58:05) against the stated standard-edition total (60:38) — a 2m33s
-- gap far too large to be rounding. Every track was then re-verified
-- individually; the corrected lengths sum to 60:39, a 1-second match.
-- Lesson for future albums: always sum and cross-check against the
-- stated total before trusting a bulk-fetched tracklist table.

INSERT INTO albums (title, release_date, album_type)
VALUES ('evermore', '2020-12-11', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @dessner  := (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner' LIMIT 1);
SET @antonoff := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);
SET @alwyn    := (SELECT artist_id FROM artists WHERE name = 'Joe Alwyn' LIMIT 1);
SET @vernon   := (SELECT artist_id FROM artists WHERE name = 'Justin Vernon' LIMIT 1);

INSERT INTO artists (name) VALUES ('Bryce Dessner');
SET @bdessner := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('BJ Burton');
SET @burton := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('James McAllister');
SET @mcallister := LAST_INSERT_ID();

-- 1. willow
INSERT INTO songs (title, original_release_year) VALUES ('willow', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 214);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 2. champagne problems
INSERT INTO songs (title, original_release_year) VALUES ('champagne problems', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 3. gold rush
INSERT INTO songs (title, original_release_year) VALUES ('gold rush', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 186);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 4. 'tis the damn season
INSERT INTO songs (title, original_release_year) VALUES ("'tis the damn season", 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 229);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 5. tolerate it
INSERT INTO songs (title, original_release_year) VALUES ('tolerate it', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 6. no body, no crime (feat. HAIM)
INSERT INTO songs (title, original_release_year) VALUES ('no body, no crime', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 215);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 7. happiness
INSERT INTO songs (title, original_release_year) VALUES ('happiness', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 315);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 8. dorothea
INSERT INTO songs (title, original_release_year) VALUES ('dorothea', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 225);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 9. coney island (feat. The National)
INSERT INTO songs (title, original_release_year) VALUES ('coney island', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 275);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn), (@rec, @dessner), (@rec, @bdessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner), (@rec, @bdessner);

-- 10. ivy (feat. Bon Iver)
INSERT INTO songs (title, original_release_year) VALUES ('ivy', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 260);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 11. cowboy like me
INSERT INTO songs (title, original_release_year) VALUES ('cowboy like me', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 275);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 12. long story short
INSERT INTO songs (title, original_release_year) VALUES ('long story short', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 215);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 13. marjorie
INSERT INTO songs (title, original_release_year) VALUES ('marjorie', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 257);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 14. closure
INSERT INTO songs (title, original_release_year) VALUES ('closure', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 180);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @vernon), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @burton), (@rec, @mcallister), (@rec, @dessner);

-- 15. evermore (feat. Bon Iver)
INSERT INTO songs (title, original_release_year) VALUES ('evermore', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 304);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @alwyn), (@rec, @vernon);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 16. right where you left me (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('right where you left me', 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 17. it's time to go (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ("it's time to go", 2020);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 254);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);
