-- Seed data: Fearless (Taylor's Version) (2021), 26 tracks.
-- Run AFTER sql/2008_fearless.sql — tracks 1-19 reuse the same `songs`
-- rows as the original album (same composition, new recording), looked
-- up by title. Tracks 20-26 are new songs (a re-recorded standalone
-- single, plus six "From the Vault" songs never previously released).
-- Credits/durations per Wikipedia, cross-checked against the album's
-- official 106:20 total runtime.
--
-- This is the earliest-released Taylor's Version album, so it's the
-- file responsible for creating Christopher Rowe (her re-recording
-- producer) fresh in this catalog; every later Taylor's Version file
-- just looks him up. Aaron Dessner, by contrast, already exists by
-- this point — he was created in sql/2020_07_folklore.sql, which
-- predates this album's April 2021 release.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Fearless (Taylor''s Version)', '2021-04-09', 'taylors_version');
SET @album_id := LAST_INSERT_ID();

SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @antonoff := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);
SET @dessner  := (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner' LIMIT 1);
SET @liz_rose := (SELECT artist_id FROM artists WHERE name = 'Liz Rose' LIMIT 1);
SET @lindsey  := (SELECT artist_id FROM artists WHERE name = 'Hillary Lindsey' LIMIT 1);
SET @caillat  := (SELECT artist_id FROM artists WHERE name = 'Colbie Caillat' LIMIT 1);
SET @rich     := (SELECT artist_id FROM artists WHERE name = 'John Rich' LIMIT 1);
SET @tljames  := (SELECT artist_id FROM artists WHERE name = 'Tommy Lee James' LIMIT 1);
SET @cbarlowe := (SELECT artist_id FROM artists WHERE name = 'Cary Barlowe' LIMIT 1);
SET @nbarlowe := (SELECT artist_id FROM artists WHERE name = 'Nathan Barlowe' LIMIT 1);

INSERT INTO artists (name) VALUES ('Christopher Rowe');
SET @rowe := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Scooter Carusoe');
SET @carusoe := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Brad Warren');
SET @bwarren := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Brett Warren');
SET @brwarren := LAST_INSERT_ID();

-- Tracks 1-19: re-recordings of songs already in `songs` from the
-- original Fearless / Platinum Edition. Producers are Swift + Rowe
-- across the board for these; songwriter credits are unchanged.

-- 1. Fearless
SET @song := (SELECT song_id FROM songs WHERE title = 'Fearless' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 241);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose), (@rec, @lindsey);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 2. Fifteen
SET @song := (SELECT song_id FROM songs WHERE title = 'Fifteen' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 294);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 3. Love Story
SET @song := (SELECT song_id FROM songs WHERE title = 'Love Story' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 4. Hey Stephen
SET @song := (SELECT song_id FROM songs WHERE title = 'Hey Stephen' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 254);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 5. White Horse
SET @song := (SELECT song_id FROM songs WHERE title = 'White Horse' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 6. You Belong with Me
SET @song := (SELECT song_id FROM songs WHERE title = 'You Belong with Me' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 7. Breathe (feat. Colbie Caillat)
SET @song := (SELECT song_id FROM songs WHERE title = 'Breathe' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 263);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @caillat);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 8. Tell Me Why
SET @song := (SELECT song_id FROM songs WHERE title = 'Tell Me Why' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 200);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 9. You're Not Sorry
SET @song := (SELECT song_id FROM songs WHERE title = "You're Not Sorry" LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 261);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 10. The Way I Loved You
SET @song := (SELECT song_id FROM songs WHERE title = 'The Way I Loved You' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 243);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rich);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 11. Forever & Always
SET @song := (SELECT song_id FROM songs WHERE title = 'Forever & Always' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 225);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 12. The Best Day
SET @song := (SELECT song_id FROM songs WHERE title = 'The Best Day' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 13. Change
SET @song := (SELECT song_id FROM songs WHERE title = 'Change' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 279);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 14. Jump Then Fall (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Jump Then Fall' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 14, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 15. Untouchable (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Untouchable' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 312);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tljames), (@rec, @cbarlowe), (@rec, @nbarlowe);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 16. Forever & Always (Piano Version) (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Forever & Always (Piano Version)' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 267);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 17. Come In with the Rain (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Come In with the Rain' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 18. Superstar (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Superstar' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 263);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 19. The Other Side of the Door (from the Platinum Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'The Other Side of the Door' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 20. Today Was a Fairytale — re-recording of a standalone 2010 single
-- (from the "Valentine's Day" soundtrack), not originally part of
-- either Fearless edition, but included here as a bonus track.
INSERT INTO songs (title, original_release_year) VALUES ('Today Was a Fairytale', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 241);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'Bonus Track');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 21-26: "From the Vault" — previously unreleased songs.

-- 21. You All Over Me (feat. Maren Morris)
INSERT INTO songs (title, original_release_year) VALUES ('You All Over Me', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @carusoe);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 22. Mr. Perfectly Fine
INSERT INTO songs (title, original_release_year) VALUES ('Mr. Perfectly Fine', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 277);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 22, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 23. We Were Happy
INSERT INTO songs (title, original_release_year) VALUES ('We Were Happy', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 23, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 24. That's When (feat. Keith Urban)
INSERT INTO songs (title, original_release_year) VALUES ("That's When", 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 189);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 24, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @bwarren), (@rec, @brwarren);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 25. Don't You
INSERT INTO songs (title, original_release_year) VALUES ("Don't You", 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 208);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 25, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tljames);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 26. Bye Bye Baby
INSERT INTO songs (title, original_release_year) VALUES ('Bye Bye Baby', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 242);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 26, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
