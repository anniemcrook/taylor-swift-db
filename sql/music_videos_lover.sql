-- Music video data: Lover era. 4 singles had official full music
-- videos (verified via oEmbed to be on @TaylorSwift): "Me!", "You
-- Need to Calm Down", "Lover", "The Man". "Cruel Summer" was released
-- as a single in 2023 but never got a full music video (only a lyric
-- video). No Taylor's Version exists for this album.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=-BjZmE2gtdo' WHERE recording_id = 287; -- Lover
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=AqAJLh9wuZ0' WHERE recording_id = 288; -- The Man
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Dkk9gvTmCXY' WHERE recording_id = 298; -- You Need to Calm Down
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=FuXNumBwDOM' WHERE recording_id = 300; -- Me!
