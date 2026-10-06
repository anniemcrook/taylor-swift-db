-- Music video data: Red era. 7 original singles with videos, plus two
-- Red (Taylor's Version)-exclusive videos: the "All Too Well" short
-- film (for the extended 10-minute recording specifically) and
-- "I Bet You Think About Me" (a vault song with no original to
-- borrow from). Every URL verified via oEmbed to be on @TaylorSwift.
--
-- Per the user's "her channel only" rule, several seemingly-official
-- "Taylor's Version" re-recording videos were EXCLUDED here because
-- they're only hosted on a separate channel, "@TheTaylorsVersion"
-- (We Are Never Ever Getting Back Together TV, I Knew You Were
-- Trouble TV, 22 TV, Red TV, The Last Time TV), or on other
-- non-qualifying channels (Begin Again TV, Everything Has Changed TV
-- — not found on her channel at all). Those recordings are left NULL
-- and will correctly borrow/label the original's video instead.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=WA4iX5D9Z64' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'We Are Never Ever Getting Back Together'); -- We Are Never Ever Getting Back Together
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=vNoKguSdy4Y' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Knew You Were Trouble'); -- I Knew You Were Trouble
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=AgFeZr5ptV8' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = '22'); -- 22
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=w1oM3kQpXRo' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Everything Has Changed'); -- Everything Has Changed
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Zlot0i3Zykw' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Red'); -- Red
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QuijXg8wm28' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Last Time'); -- The Last Time
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=cMPEd8m79Hw' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Begin Again'); -- Begin Again
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=tollGa3S0o8' WHERE version_type = 'other' AND song_id = (SELECT song_id FROM songs WHERE title = 'All Too Well'); -- All Too Well (10 Minute Version) (Short Film)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=5UMCrq-bBCg' WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Bet You Think About Me'); -- I Bet You Think About Me (Taylor's Version) [feat. Chris Stapleton]
