-- Music video data: reputation era. 4 of its singles had official
-- full music videos (verified via oEmbed to be on @TaylorSwift):
-- "...Ready for It?", "End Game", "Delicate", "Look What You Made Me
-- Do". "New Year's Day" and "Getaway Car" were released as singles
-- but never got a full music video (audio-only / visualizer), so
-- they're correctly left without one. No Taylor's Version exists for
-- this album.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=wIft-t-MQuE' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = '...Ready for It?'); -- ...Ready for It?
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=dfnCAmr569k' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'End Game'); -- End Game
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=tCXGJQYZ9JA' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Delicate'); -- Delicate
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=3tmd-ClpJxA' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Look What You Made Me Do'); -- Look What You Made Me Do
