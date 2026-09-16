-- Seed data: reputation (2017), 15 tracks. No deluxe edition added new
-- songs for this album, so there's nothing to tag with `edition`.
-- Credits/durations per Wikipedia, cross-checked track-by-track against
-- Apple Music. Note: Wikipedia's infobox states a 55:45 total, but the
-- sum of its own per-track lengths is 55:38 — a minor infobox error on
-- Wikipedia's end. The per-track lengths themselves were independently
-- confirmed, so they're used as-is here.

INSERT INTO albums (title, release_date, album_type)
VALUES ('reputation', '2017-11-10', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor    := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @martin    := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);
SET @antonoff  := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);
SET @payami    := (SELECT artist_id FROM artists WHERE name = 'Ali Payami' LIMIT 1);
SET @sheeran   := (SELECT artist_id FROM artists WHERE name = 'Ed Sheeran' LIMIT 1);

INSERT INTO artists (name) VALUES ('Ilya');
SET @ilya := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Future');
SET @future := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Richard Fairbrass');
SET @rfairbrass := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Fred Fairbrass');
SET @ffairbrass := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Rob Manzoli');
SET @manzoli := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Oscar Görres');
SET @gorres := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Oscar Holter');
SET @holter := LAST_INSERT_ID();

-- 1. ...Ready for It?
INSERT INTO songs (title, original_release_year) VALUES ('...Ready for It?', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 208);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @payami);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @payami);

-- 2. End Game (feat. Ed Sheeran, Future)
INSERT INTO songs (title, original_release_year) VALUES ('End Game', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @sheeran), (@rec, @future);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @ilya);

-- 3. I Did Something Bad
INSERT INTO songs (title, original_release_year) VALUES ('I Did Something Bad', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 4. Don't Blame Me
INSERT INTO songs (title, original_release_year) VALUES ("Don't Blame Me", 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 236);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 5. Delicate
INSERT INTO songs (title, original_release_year) VALUES ('Delicate', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 232);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 6. Look What You Made Me Do
INSERT INTO songs (title, original_release_year) VALUES ('Look What You Made Me Do', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff), (@rec, @rfairbrass), (@rec, @ffairbrass), (@rec, @manzoli);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 7. So It Goes...
INSERT INTO songs (title, original_release_year) VALUES ('So It Goes...', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 227);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @gorres);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @gorres);

-- 8. Gorgeous
INSERT INTO songs (title, original_release_year) VALUES ('Gorgeous', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 209);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 9. Getaway Car
INSERT INTO songs (title, original_release_year) VALUES ('Getaway Car', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 233);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 10. King of My Heart
INSERT INTO songs (title, original_release_year) VALUES ('King of My Heart', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 214);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback);

-- 11. Dancing with Our Hands Tied
INSERT INTO songs (title, original_release_year) VALUES ('Dancing with Our Hands Tied', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 211);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback), (@rec, @holter);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @martin), (@rec, @shellback), (@rec, @holter);

-- 12. Dress
INSERT INTO songs (title, original_release_year) VALUES ('Dress', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 13. This Is Why We Can't Have Nice Things
INSERT INTO songs (title, original_release_year) VALUES ("This Is Why We Can't Have Nice Things", 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 207);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 14. Call It What You Want
INSERT INTO songs (title, original_release_year) VALUES ('Call It What You Want', 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 203);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 15. New Year's Day
INSERT INTO songs (title, original_release_year) VALUES ("New Year's Day", 2017);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 235);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
