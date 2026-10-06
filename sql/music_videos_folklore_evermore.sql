-- Music video data: folklore and evermore. Each album got exactly
-- one full official music video — "cardigan" for folklore, "willow"
-- for evermore — with every other track (including other singles
-- like "exile", "betty", "no body, no crime", "coney island") only
-- getting a lyric video. Both verified via oEmbed to be on
-- @TaylorSwift. Neither album has a Taylor's Version.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=K-a8s8OLBSE' WHERE recording_id = 304; -- cardigan
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=RsEZmictANA' WHERE recording_id = 320; -- willow
