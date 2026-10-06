-- Music video data: reputation era. 4 of its singles had official
-- full music videos (verified via oEmbed to be on @TaylorSwift):
-- "...Ready for It?", "End Game", "Delicate", "Look What You Made Me
-- Do". "New Year's Day" and "Getaway Car" were released as singles
-- but never got a full music video (audio-only / visualizer), so
-- they're correctly left without one. No Taylor's Version exists for
-- this album.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=wIft-t-MQuE' WHERE recording_id = 270; -- ...Ready for It?
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=dfnCAmr569k' WHERE recording_id = 271; -- End Game
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=tCXGJQYZ9JA' WHERE recording_id = 274; -- Delicate
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=3tmd-ClpJxA' WHERE recording_id = 275; -- Look What You Made Me Do
