-- Music video data: Fearless era (trial run for the Music Video
-- column/feature). Every URL below was individually verified via
-- YouTube's oEmbed endpoint to confirm it's actually hosted on
-- Taylor Swift's own channel (@TaylorSwift), not a label/fan
-- reupload — several first-page search results for these songs
-- turned out to be from channels like "countrymusicgirl16" or
-- "LegacyNationMusic", not her.
--
-- Only "The Best Day (Taylor's Version)" got a genuine new official
-- music video; every other Fearless-era re-recording (Love Story,
-- Fearless, Fifteen, You Belong with Me, Change) only ever got a
-- lyric video, so those recordings are deliberately left NULL here —
-- the tracklist page's borrow logic will show the original's video
-- labeled "(original version)" for them automatically.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=ptSjNWnzpjg' WHERE recording_id = 131; -- Fearless (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=D1Xr-JFLxik' WHERE recording_id = 135; -- White Horse (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=VuNIsY6JdUw' WHERE recording_id = 136; -- You Belong with Me (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Pb-K2tXWK4w' WHERE recording_id = 132; -- Fifteen (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=l4_6eQm7RTQ' WHERE recording_id = 142; -- The Best Day (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=B1jYllE0T-k' WHERE recording_id = 143; -- Change (original)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=n0cde-Km05o' WHERE recording_id = 161; -- The Best Day (Taylor's Version) — its own new video
