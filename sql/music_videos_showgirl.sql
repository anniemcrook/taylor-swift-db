-- Music video data: The Life of a Showgirl (incl. The Encore). 4
-- full official music videos so far (verified via oEmbed to be on
-- @TaylorSwift): "The Fate of Ophelia", "Opalite", "Elizabeth Taylor"
-- (all singles from the standard album), and "Patient Zero" (the
-- lead single from the Encore bonus tracks, released Sept 2026).
-- This album is still an active era with singles continuing to roll
-- out, so revisit this file as more videos are released.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=ko70cExuzZM' WHERE recording_id = 392; -- The Fate of Ophelia
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=WqbJT_vC0rs' WHERE recording_id = 393; -- Elizabeth Taylor
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=1FVF-9KQiPo' WHERE recording_id = 394; -- Opalite
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=mw3kSNIxjqo' WHERE recording_id = 404; -- Patient Zero
