-- Music video data: Midnights era. 4 full official music videos
-- (verified via oEmbed to be on @TaylorSwift): "Anti-Hero", "Lavender
-- Haze", "Bejeweled", and — notably — the Ice Spice remix of "Karma"
-- (not the original recording). "Snow on the Beach" only ever got a
-- lyric video. The original "Karma" recording is left NULL; the
-- existing borrow logic will correctly pick up the remix's video
-- (there being no 'original'-type video available to prefer) and
-- label it "(remix)".

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=h8DLofLM7No' WHERE recording_id = 337; -- Lavender Haze
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=b1kbLwvqugk' WHERE recording_id = 339; -- Anti-Hero
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=b7QlX3yR2xs' WHERE recording_id = 345; -- Bejeweled
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=XzOvgu3GPwY' WHERE recording_id = 359; -- Karma (feat. Ice Spice) [remix]
