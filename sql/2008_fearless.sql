-- Seed data: Fearless (2008 standard edition, 13 tracks) plus the
-- 2009 Platinum Edition's 6 bonus tracks, tagged via album_tracks.edition.
-- Credits/durations per Wikipedia; all tracks produced by Taylor Swift
-- and Nathan Chapman (confirmed via multiple retailer/discography sources).

INSERT INTO albums (title, release_date, album_type)
VALUES ('Fearless', '2008-11-11', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor  := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @chapman := (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman' LIMIT 1);
SET @liz_rose := (SELECT artist_id FROM artists WHERE name = 'Liz Rose' LIMIT 1);

INSERT INTO artists (name) VALUES ('Hillary Lindsey');
SET @lindsey := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Colbie Caillat');
SET @caillat := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('John Rich');
SET @rich := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Cary Barlowe');
SET @cbarlowe := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Nathan Barlowe');
SET @nbarlowe := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Tommy Lee James');
SET @tljames := LAST_INSERT_ID();

-- 1. Fearless
INSERT INTO songs (title, original_release_year) VALUES ('Fearless', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 241);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose), (@rec, @lindsey);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 2. Fifteen
INSERT INTO songs (title, original_release_year) VALUES ('Fifteen', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 294);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 3. Love Story
INSERT INTO songs (title, original_release_year) VALUES ('Love Story', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 4. Hey Stephen
INSERT INTO songs (title, original_release_year) VALUES ('Hey Stephen', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 254);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 5. White Horse
INSERT INTO songs (title, original_release_year) VALUES ('White Horse', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 6. You Belong with Me
INSERT INTO songs (title, original_release_year) VALUES ('You Belong with Me', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 231);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 7. Breathe (feat. Colbie Caillat)
INSERT INTO songs (title, original_release_year) VALUES ('Breathe', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 263);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @caillat);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 8. Tell Me Why
INSERT INTO songs (title, original_release_year) VALUES ('Tell Me Why', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 200);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 9. You're Not Sorry
INSERT INTO songs (title, original_release_year) VALUES ("You're Not Sorry", 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 261);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 10. The Way I Loved You
INSERT INTO songs (title, original_release_year) VALUES ('The Way I Loved You', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 243);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rich);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 11. Forever & Always
INSERT INTO songs (title, original_release_year) VALUES ('Forever & Always', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 225);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 12. The Best Day
INSERT INTO songs (title, original_release_year) VALUES ('The Best Day', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 13. Change
INSERT INTO songs (title, original_release_year) VALUES ('Change', 2008);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 280);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 14. Jump Then Fall (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Jump Then Fall', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 236);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 14, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 15. Untouchable (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Untouchable', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 311);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @tljames), (@rec, @cbarlowe), (@rec, @nbarlowe);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 16. Forever & Always (Piano Version) (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Forever & Always (Piano Version)', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 267);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 17. Come In with the Rain (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Come In with the Rain', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 18. Superstar (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Superstar', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 261);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 19. The Other Side of the Door (Platinum Edition)
INSERT INTO songs (title, original_release_year) VALUES ('The Other Side of the Door', 2009);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'Platinum Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);
