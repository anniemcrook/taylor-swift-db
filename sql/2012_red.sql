-- Seed data: Red (2012 standard edition, 16 tracks) plus the Deluxe
-- Edition's 6 bonus tracks (3 new songs + 3 alternate recordings of
-- existing songs: two original demos and an acoustic version).
-- Credits/durations per Wikipedia, cross-checked against the standard
-- edition's official 65:09 total runtime and the deluxe bonus content's
-- 25:19 total runtime (both matched exactly).

INSERT INTO albums (title, release_date, album_type)
VALUES ('Red', '2012-10-22', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor  := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @chapman := (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman' LIMIT 1);
SET @martin  := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);
SET @liz_rose := (SELECT artist_id FROM artists WHERE name = 'Liz Rose' LIMIT 1);

INSERT INTO artists (name) VALUES ('Dann Huff');
SET @huff := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Dan Wilson');
SET @wilson := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Gary Lightbody');
SET @lightbody := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Jacknife Lee');
SET @jlee := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Jeff Bhasker');
SET @bhasker := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Butch Walker');
SET @bwalker := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Ed Sheeran');
SET @sheeran := LAST_INSERT_ID();

-- 1. State of Grace
INSERT INTO songs (title, original_release_year) VALUES ('State of Grace', 2012);
SET @song := LAST_INSERT_ID();
SET @song_sog := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 295);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 2. Red
INSERT INTO songs (title, original_release_year) VALUES ('Red', 2012);
SET @song := LAST_INSERT_ID();
SET @song_red := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 223);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman), (@rec, @huff);

-- 3. Treacherous
INSERT INTO songs (title, original_release_year) VALUES ('Treacherous', 2012);
SET @song := LAST_INSERT_ID();
SET @song_treacherous := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 242);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @wilson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @wilson);

-- 4. I Knew You Were Trouble
INSERT INTO songs (title, original_release_year) VALUES ('I Knew You Were Trouble', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 219);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 5. All Too Well
INSERT INTO songs (title, original_release_year) VALUES ('All Too Well', 2012);
SET @song := LAST_INSERT_ID();
SET @song_atw := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 329);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 6. 22
INSERT INTO songs (title, original_release_year) VALUES ('22', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 232);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 7. I Almost Do
INSERT INTO songs (title, original_release_year) VALUES ('I Almost Do', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 8. We Are Never Ever Getting Back Together
INSERT INTO songs (title, original_release_year) VALUES ('We Are Never Ever Getting Back Together', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 193);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @taylor);

-- 9. Stay Stay Stay
INSERT INTO songs (title, original_release_year) VALUES ('Stay Stay Stay', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 205);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 10. The Last Time (feat. Gary Lightbody)
INSERT INTO songs (title, original_release_year) VALUES ('The Last Time', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 299);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @lightbody), (@rec, @jlee);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @jlee);

-- 11. Holy Ground
INSERT INTO songs (title, original_release_year) VALUES ('Holy Ground', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 202);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bhasker);

-- 12. Sad Beautiful Tragic
INSERT INTO songs (title, original_release_year) VALUES ('Sad Beautiful Tragic', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 284);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 13. The Lucky One
INSERT INTO songs (title, original_release_year) VALUES ('The Lucky One', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bhasker);

-- 14. Everything Has Changed (feat. Ed Sheeran)
INSERT INTO songs (title, original_release_year) VALUES ('Everything Has Changed', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @sheeran);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bwalker);

-- 15. Starlight
INSERT INTO songs (title, original_release_year) VALUES ('Starlight', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman), (@rec, @huff);

-- 16. Begin Again
INSERT INTO songs (title, original_release_year) VALUES ('Begin Again', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 16);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman), (@rec, @huff);

-- 17. The Moment I Knew (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('The Moment I Knew', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 286);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 18. Come Back... Be Here (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Come Back... Be Here', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 223);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @wilson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @wilson);

-- 19. Girl at Home (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Girl at Home', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 20. Treacherous (Original Demo Recording) (Deluxe Edition) — same
-- song as track 3, a second recording rather than a new song.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_treacherous, 'demo', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @wilson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @wilson);

-- 21. Red (Original Demo Recording) (Deluxe Edition) — same song as
-- track 2.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_red, 'demo', 227);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 22. State of Grace (Acoustic Version) (Deluxe Edition) — same song
-- as track 1.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_sog, 'acoustic', 323);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 22, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);
