-- Seed data: Red (Taylor's Version) (2021), 30 tracks.
-- Run AFTER sql/2012_red.sql — tracks 1-19 reuse the same `songs`
-- rows as the original standard + deluxe tracks (looked up by title).
-- Track 20 ("State of Grace (Acoustic Version)") is a second acoustic
-- recording of that same song, produced fresh for this release.
-- Tracks 21-29 are nine new "From the Vault" songs; track 30 is a new,
-- much longer recording ("10 Minute Version") of the existing "All Too
-- Well" song. Credits/durations per Wikipedia, cross-checked against
-- the album's official 130:26 total runtime (matched exactly). A
-- couple of underspecified production credits ("Girl at Home", "The
-- Very First Night") were independently confirmed via web search.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Red (Taylor''s Version)', '2021-11-12', 'taylors_version');
SET @album_id := LAST_INSERT_ID();

SET @taylor    := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @rowe      := (SELECT artist_id FROM artists WHERE name = 'Christopher Rowe' LIMIT 1);
SET @martin    := (SELECT artist_id FROM artists WHERE name = 'Max Martin' LIMIT 1);
SET @shellback := (SELECT artist_id FROM artists WHERE name = 'Shellback' LIMIT 1);
SET @liz_rose  := (SELECT artist_id FROM artists WHERE name = 'Liz Rose' LIMIT 1);
SET @wilson    := (SELECT artist_id FROM artists WHERE name = 'Dan Wilson' LIMIT 1);
SET @lightbody := (SELECT artist_id FROM artists WHERE name = 'Gary Lightbody' LIMIT 1);
SET @jlee      := (SELECT artist_id FROM artists WHERE name = 'Jacknife Lee' LIMIT 1);
SET @bhasker   := (SELECT artist_id FROM artists WHERE name = 'Jeff Bhasker' LIMIT 1);
SET @bwalker   := (SELECT artist_id FROM artists WHERE name = 'Butch Walker' LIMIT 1);
SET @sheeran   := (SELECT artist_id FROM artists WHERE name = 'Ed Sheeran' LIMIT 1);
SET @dessner   := (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner' LIMIT 1);
SET @antonoff  := (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff' LIMIT 1);

INSERT INTO artists (name) VALUES ('Paul Mirkovich');
SET @mirkovich := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Elvira Anderfjärd');
SET @anderfjard := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Maya Thompson');
SET @mthompson := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Tony Berg');
SET @tberg := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Patrick Monahan');
SET @monahan := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Lori McKenna');
SET @mckenna := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Mark Foster');
SET @foster := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Tim Blacksmith');
SET @blacksmith := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Danny D');
SET @dannyd := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Davide Rossi');
SET @rossi := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Espen Lind');
SET @elind := LAST_INSERT_ID();
INSERT INTO artists (name) VALUES ('Amund Bjørklund');
SET @abjorklund := LAST_INSERT_ID();

-- 1. State of Grace
SET @song := (SELECT song_id FROM songs WHERE title = 'State of Grace' LIMIT 1);
SET @song_sog := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 295);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 2. Red
SET @song := (SELECT song_id FROM songs WHERE title = 'Red' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 223);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 3. Treacherous
SET @song := (SELECT song_id FROM songs WHERE title = 'Treacherous' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 242);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @wilson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @wilson);

-- 4. I Knew You Were Trouble
SET @song := (SELECT song_id FROM songs WHERE title = 'I Knew You Were Trouble' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 219);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @shellback);

-- 5. All Too Well
SET @song := (SELECT song_id FROM songs WHERE title = 'All Too Well' LIMIT 1);
SET @song_atw := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 329);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 6. 22
SET @song := (SELECT song_id FROM songs WHERE title = '22' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @shellback);

-- 7. I Almost Do
SET @song := (SELECT song_id FROM songs WHERE title = 'I Almost Do' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 244);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 8. We Are Never Ever Getting Back Together
SET @song := (SELECT song_id FROM songs WHERE title = 'We Are Never Ever Getting Back Together' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 193);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @shellback);

-- 9. Stay Stay Stay
SET @song := (SELECT song_id FROM songs WHERE title = 'Stay Stay Stay' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 205);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 10. The Last Time (feat. Gary Lightbody)
SET @song := (SELECT song_id FROM songs WHERE title = 'The Last Time' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 299);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @lightbody), (@rec, @jlee);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @jlee);

-- 11. Holy Ground
SET @song := (SELECT song_id FROM songs WHERE title = 'Holy Ground' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 202);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bhasker);

-- 12. Sad Beautiful Tragic
SET @song := (SELECT song_id FROM songs WHERE title = 'Sad Beautiful Tragic' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 284);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @mirkovich);

-- 13. The Lucky One
SET @song := (SELECT song_id FROM songs WHERE title = 'The Lucky One' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bhasker);

-- 14. Everything Has Changed (feat. Ed Sheeran)
SET @song := (SELECT song_id FROM songs WHERE title = 'Everything Has Changed' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 245);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @sheeran);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @bwalker);

-- 15. Starlight
SET @song := (SELECT song_id FROM songs WHERE title = 'Starlight' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 15);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @mirkovich);

-- 16. Begin Again
SET @song := (SELECT song_id FROM songs WHERE title = 'Begin Again' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 16);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 17. The Moment I Knew (from the Deluxe Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'The Moment I Knew' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 285);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe), (@rec, @mirkovich);

-- 18. Come Back... Be Here (from the Deluxe Edition)
SET @song := (SELECT song_id FROM songs WHERE title = 'Come Back... Be Here' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 223);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @wilson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @wilson);

-- 19. Girl at Home (from the Deluxe Edition) — reworked as synth-pop
-- for this release; produced solely by Elvira Anderfjärd (confirmed
-- via search, no Swift/Rowe co-production credit on this one).
SET @song := (SELECT song_id FROM songs WHERE title = 'Girl at Home' LIMIT 1);
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 220);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @anderfjard);

-- 20. State of Grace (Acoustic Version) (from the Deluxe Edition) —
-- same song as track 1, a freshly recorded acoustic take (distinct
-- from the 2012 deluxe acoustic recording).
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_sog, 'acoustic', 321);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 21-30: "From the Vault" — previously unreleased songs, plus the
-- extended 10 Minute Version of "All Too Well".

-- 21. Ronan — previously released as a 2012 charity single, but never
-- on an album until this release.
INSERT INTO songs (title, original_release_year) VALUES ('Ronan', 2012);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 264);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 21, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @mthompson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @rowe);

-- 22. Better Man
INSERT INTO songs (title, original_release_year) VALUES ('Better Man', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 297);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 22, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @dessner);

-- 23. Nothing New (feat. Phoebe Bridgers)
INSERT INTO songs (title, original_release_year) VALUES ('Nothing New', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 258);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 23, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner), (@rec, @tberg);

-- 24. Babe
INSERT INTO songs (title, original_release_year) VALUES ('Babe', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 224);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 24, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @monahan);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 25. Message in a Bottle
INSERT INTO songs (title, original_release_year) VALUES ('Message in a Bottle', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 225);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 25, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @martin), (@rec, @shellback);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @anderfjard), (@rec, @shellback);

-- 26. I Bet You Think About Me (feat. Chris Stapleton)
INSERT INTO songs (title, original_release_year) VALUES ('I Bet You Think About Me', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 285);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 26, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @mckenna);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 27. Forever Winter
INSERT INTO songs (title, original_release_year) VALUES ('Forever Winter', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 263);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 27, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @foster);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);

-- 28. Run (feat. Ed Sheeran)
INSERT INTO songs (title, original_release_year) VALUES ('Run', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 28, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @sheeran);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @dessner);

-- 29. The Very First Night — written in 2012 for Red but shelved
-- until this release. Production credited to the Espionage duo
-- (Espen Lind & Amund Bjørklund) plus Tim Blacksmith, Danny D, and
-- Davide Rossi (per muso.ai credits, verified via search).
INSERT INTO songs (title, original_release_year) VALUES ('The Very First Night', 2021);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'taylors_version', 200);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 29, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @elind), (@rec, @abjorklund);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @elind), (@rec, @abjorklund), (@rec, @blacksmith), (@rec, @dannyd), (@rec, @rossi);

-- 30. All Too Well (10 Minute Version) (From the Vault) — same song
-- as track 5, an extended recording rather than a new song.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_atw, 'other', 613);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 30, 'From the Vault');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @liz_rose);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @antonoff);
