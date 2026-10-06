-- Music video data: Fearless era (trial run for the Music Video
-- column/feature). Every URL was individually verified via YouTube's
-- oEmbed endpoint to confirm it's actually hosted on Taylor Swift's
-- own channel (@TaylorSwift), not a label/fan reupload — several
-- first-page search results for these songs turned out to be from
-- channels like "countrymusicgirl16" or "LegacyNationMusic", not her.
--
-- Only "The Best Day (Taylor's Version)" got a genuine new official
-- music video among the re-recordings; "Fearless", "Fifteen", "You
-- Belong with Me", and "Change" (Taylor's Version) only ever got a
-- lyric video, so those recordings are deliberately left NULL here —
-- the tracklist page's borrow logic will show the original's video
-- labeled "(original version)" for them automatically.
--
-- "Love Story" was the very first video added to this catalog (the
-- proof-of-concept for the whole Music Video feature, before this
-- file's naming convention existed), so it's included here too for
-- completeness/reproducibility.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=8xg3vE8Ie_E' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Love Story'); -- Love Story
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=ptSjNWnzpjg' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fearless'); -- Fearless
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=D1Xr-JFLxik' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'White Horse'); -- White Horse
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=VuNIsY6JdUw' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Belong with Me'); -- You Belong with Me
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Pb-K2tXWK4w' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fifteen'); -- Fifteen
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=l4_6eQm7RTQ' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Best Day'); -- The Best Day
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=B1jYllE0T-k' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Change'); -- Change
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=n0cde-Km05o' WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Best Day'); -- The Best Day (Taylor's Version) — its own new video
