-- Music video data: Midnights era. 4 full official music videos
-- (verified via oEmbed to be on @TaylorSwift): "Anti-Hero", "Lavender
-- Haze", "Bejeweled", and — notably — the Ice Spice remix of "Karma"
-- (not the original recording). "Snow on the Beach" only ever got a
-- lyric video. The original "Karma" recording is left NULL; the
-- existing borrow logic will correctly pick up the remix's video
-- (there being no 'original'-type video available to prefer) and
-- label it "(remix)".
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=h8DLofLM7No' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Lavender Haze'); -- Lavender Haze
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=b1kbLwvqugk' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Anti-Hero'); -- Anti-Hero
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=b7QlX3yR2xs' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bejeweled'); -- Bejeweled
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=XzOvgu3GPwY' WHERE version_type = 'remix' AND song_id = (SELECT song_id FROM songs WHERE title = 'Karma'); -- Karma (feat. Ice Spice) [remix]
