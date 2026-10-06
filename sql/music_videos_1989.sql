-- Music video data: 1989 era. 7 original singles had official music
-- videos, all found via each song's Wikipedia infobox and verified
-- via oEmbed to be on @TaylorSwift. No 1989 (Taylor's Version) track
-- got a new full music video (only lyric videos, e.g. for "Blank
-- Space", "Bad Blood", "This Love", "How You Get the Girl", and the
-- vault single "Is It Over Now?"), so all TV recordings are left
-- NULL — they'll correctly borrow/label the original's video where
-- one exists, or show nothing for vault-only songs with no original.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=nfWlot6h_JM' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Shake It Off'); -- Shake It Off
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=e-ORhEE9VVg' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Blank Space'); -- Blank Space
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=-CmadmM5cOk' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Style'); -- Style
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QcIy9NiNbmo' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bad Blood'); -- Bad Blood
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=IdneKLhsWOQ' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Wildest Dreams'); -- Wildest Dreams
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=JLf9q36UsBk' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Out of the Woods'); -- Out of the Woods
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=wyK7YuwUWsU' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'New Romantics'); -- New Romantics
