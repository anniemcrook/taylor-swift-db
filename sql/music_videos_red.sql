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

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=WA4iX5D9Z64' WHERE recording_id = 225; -- We Are Never Ever Getting Back Together
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=vNoKguSdy4Y' WHERE recording_id = 221; -- I Knew You Were Trouble
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=AgFeZr5ptV8' WHERE recording_id = 223; -- 22
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=w1oM3kQpXRo' WHERE recording_id = 231; -- Everything Has Changed
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Zlot0i3Zykw' WHERE recording_id = 219; -- Red
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QuijXg8wm28' WHERE recording_id = 227; -- The Last Time
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=cMPEd8m79Hw' WHERE recording_id = 233; -- Begin Again
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=tollGa3S0o8' WHERE recording_id = 269; -- All Too Well (10 Minute Version) (Short Film)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=5UMCrq-bBCg' WHERE recording_id = 265; -- I Bet You Think About Me (Taylor's Version) [feat. Chris Stapleton]
