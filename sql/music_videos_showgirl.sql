-- Music video data: The Life of a Showgirl (incl. The Encore). 4
-- full official music videos so far (verified via oEmbed to be on
-- @TaylorSwift): "The Fate of Ophelia", "Opalite", "Elizabeth Taylor"
-- (all singles from the standard album), and "Patient Zero" (the
-- lead single from the Encore bonus tracks, released Sept 2026).
-- This album is still an active era with singles continuing to roll
-- out, so revisit this file as more videos are released.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=ko70cExuzZM' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Fate of Ophelia'); -- The Fate of Ophelia
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=WqbJT_vC0rs' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Elizabeth Taylor'); -- Elizabeth Taylor
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=1FVF-9KQiPo' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Opalite'); -- Opalite
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=mw3kSNIxjqo' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Patient Zero'); -- Patient Zero
