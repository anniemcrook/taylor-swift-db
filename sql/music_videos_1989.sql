-- Music video data: 1989 era. 7 original singles had official music
-- videos, all found via each song's Wikipedia infobox and verified
-- via oEmbed to be on @TaylorSwift. No 1989 (Taylor's Version) track
-- got a new full music video (only lyric videos, e.g. for "Blank
-- Space", "Bad Blood", "This Love", "How You Get the Girl", and the
-- vault single "Is It Over Now?"), so all TV recordings are left
-- NULL — they'll correctly borrow/label the original's video where
-- one exists, or show nothing for vault-only songs with no original.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=nfWlot6h_JM' WHERE recording_id = 7;  -- Shake It Off
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=e-ORhEE9VVg' WHERE recording_id = 3;  -- Blank Space
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=-CmadmM5cOk' WHERE recording_id = 4;  -- Style
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QcIy9NiNbmo' WHERE recording_id = 9;  -- Bad Blood
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=IdneKLhsWOQ' WHERE recording_id = 10; -- Wildest Dreams
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=JLf9q36UsBk' WHERE recording_id = 5;  -- Out of the Woods
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=wyK7YuwUWsU' WHERE recording_id = 17; -- New Romantics
