-- Seed data: Taylor Swift (debut album, standard edition, 2006)
-- Songwriter/producer credits and durations per Wikipedia's album article.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Taylor Swift', '2006-10-24', 'studio');
SET @album_id := LAST_INSERT_ID();

-- Artists already in the table, looked up rather than hardcoded by id.
SET @taylor   := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @chapman  := (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman' LIMIT 1);

-- New artists introduced by this album.
INSERT INTO artists (name) VALUES ('Liz Rose');
SET @liz_rose := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Robert Ellis Orrall');
SET @orrall := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Angelo Petraglia');
SET @petraglia := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Brian Maher');
SET @maher := LAST_INSERT_ID();

-- 1. Tim McGraw
INSERT INTO songs (title, original_release_year) VALUES ('Tim McGraw', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 2. Picture to Burn
INSERT INTO songs (title, original_release_year) VALUES ('Picture to Burn', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 175);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 3. Teardrops on My Guitar
INSERT INTO songs (title, original_release_year) VALUES ('Teardrops on My Guitar', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 215);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 4. A Place in This World
INSERT INTO songs (title, original_release_year) VALUES ('A Place in This World', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 202);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @orrall), (@rec, @petraglia);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 5. Cold as You
INSERT INTO songs (title, original_release_year) VALUES ('Cold as You', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 241);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 6. The Outside
INSERT INTO songs (title, original_release_year) VALUES ('The Outside', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 209);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @orrall), (@rec, @chapman);

-- 7. Tied Together with a Smile
INSERT INTO songs (title, original_release_year) VALUES ('Tied Together with a Smile', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 251);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 8. Stay Beautiful
INSERT INTO songs (title, original_release_year) VALUES ('Stay Beautiful', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 9. Should've Said No
INSERT INTO songs (title, original_release_year) VALUES ("Should've Said No", 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 10. Mary's Song (Oh My My My)
INSERT INTO songs (title, original_release_year) VALUES ("Mary's Song (Oh My My My)", 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 215);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose), (@rec, @maher);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);

-- 11. Our Song
INSERT INTO songs (title, original_release_year) VALUES ('Our Song', 2006);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 204);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @chapman);
