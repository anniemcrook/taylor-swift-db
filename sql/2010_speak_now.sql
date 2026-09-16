-- Seed data: Speak Now (2010 standard edition, 14 tracks, all written
-- solely by Taylor Swift) plus the Deluxe Edition's 6 bonus tracks.
-- Three of the bonus tracks are new songs (Ours, If This Was a Movie,
-- Superman); the other three are alternate RECORDINGS of songs already
-- on the standard tracklist (acoustic / pop-mix versions), demonstrating
-- the schema's song vs. recording distinction within a single album.
-- Credits/durations per Wikipedia, cross-checked against the standard
-- edition's official 66:55 total runtime.

INSERT INTO albums (title, release_date, album_type)
VALUES ('Speak Now', '2010-10-25', 'studio');
SET @album_id := LAST_INSERT_ID();

SET @taylor  := (SELECT artist_id FROM artists WHERE name = 'Taylor Swift' LIMIT 1);
SET @chapman := (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman' LIMIT 1);

INSERT INTO artists (name) VALUES ('Martin Johnson');
SET @mjohnson := LAST_INSERT_ID();

-- 1. Mine
INSERT INTO songs (title, original_release_year) VALUES ('Mine', 2010);
SET @song := LAST_INSERT_ID();
SET @song_mine := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 2. Sparks Fly
INSERT INTO songs (title, original_release_year) VALUES ('Sparks Fly', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 260);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 2);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 3. Back to December
INSERT INTO songs (title, original_release_year) VALUES ('Back to December', 2010);
SET @song := LAST_INSERT_ID();
SET @song_b2d := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 293);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 3);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 4. Speak Now
INSERT INTO songs (title, original_release_year) VALUES ('Speak Now', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 240);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 4);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 5. Dear John
INSERT INTO songs (title, original_release_year) VALUES ('Dear John', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 403);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 5);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 6. Mean
INSERT INTO songs (title, original_release_year) VALUES ('Mean', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 237);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 6);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 7. The Story of Us
INSERT INTO songs (title, original_release_year) VALUES ('The Story of Us', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 265);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 7);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 8. Never Grow Up
INSERT INTO songs (title, original_release_year) VALUES ('Never Grow Up', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 290);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 8);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 9. Enchanted
INSERT INTO songs (title, original_release_year) VALUES ('Enchanted', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 352);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 9);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 10. Better than Revenge
INSERT INTO songs (title, original_release_year) VALUES ('Better than Revenge', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 217);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 10);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 11. Innocent
INSERT INTO songs (title, original_release_year) VALUES ('Innocent', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 302);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 11);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 12. Haunted
INSERT INTO songs (title, original_release_year) VALUES ('Haunted', 2010);
SET @song := LAST_INSERT_ID();
SET @song_haunted := @song;
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 242);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 12);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 13. Last Kiss
INSERT INTO songs (title, original_release_year) VALUES ('Last Kiss', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 367);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 13);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 14. Long Live
INSERT INTO songs (title, original_release_year) VALUES ('Long Live', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 317);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @rec, 14);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 15. Ours (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Ours', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 238);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 15, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 16. If This Was a Movie (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('If This Was a Movie', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 234);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 16, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @mjohnson);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 17. Superman (Deluxe Edition)
INSERT INTO songs (title, original_release_year) VALUES ('Superman', 2010);
SET @song := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song, 'original', 276);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 17, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 18. Back to December (Acoustic) (Deluxe Edition) — same song as
-- track 3, a second recording rather than a new song.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_b2d, 'acoustic', 292);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 18, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 19. Haunted (Acoustic) (Deluxe Edition) — same song as track 12.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_haunted, 'acoustic', 217);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 19, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);

-- 20. Mine (Pop Mix) (Deluxe Edition) — same song as track 1.
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_mine, 'remix', 230);
SET @rec := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number, edition) VALUES (@album_id, @rec, 20, 'Deluxe Edition');
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES (@rec, @taylor);
INSERT INTO recording_producers (recording_id, artist_id) VALUES (@rec, @taylor), (@rec, @chapman);
