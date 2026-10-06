-- Music video data: Lover era. 4 singles had official full music
-- videos (verified via oEmbed to be on @TaylorSwift): "Me!", "You
-- Need to Calm Down", "Lover", "The Man". "Cruel Summer" was released
-- as a single in 2023 but never got a full music video (only a lyric
-- video). No Taylor's Version exists for this album.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=-BjZmE2gtdo' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Lover'); -- Lover
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=AqAJLh9wuZ0' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Man'); -- The Man
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Dkk9gvTmCXY' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Need to Calm Down'); -- You Need to Calm Down
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=FuXNumBwDOM' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Me!'); -- Me!
