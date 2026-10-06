-- Music video data: folklore and evermore. Each album got exactly
-- one full official music video — "cardigan" for folklore, "willow"
-- for evermore — with every other track (including other singles
-- like "exile", "betty", "no body, no crime", "coney island") only
-- getting a lyric video. Both verified via oEmbed to be on
-- @TaylorSwift. Neither album has a Taylor's Version.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=K-a8s8OLBSE' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'cardigan'); -- cardigan
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=RsEZmictANA' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'willow'); -- willow
