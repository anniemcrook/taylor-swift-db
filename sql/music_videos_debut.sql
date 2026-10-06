-- Music video data: Taylor Swift (2006 debut). All 5 singles had
-- official music videos; every URL verified via YouTube's oEmbed
-- endpoint to confirm it's on @TaylorSwift's own channel, not a fan
-- reupload (several top search hits for these were from channels
-- like "seara31" or the label's own "@BigMachine" channel, neither
-- of which count per the "her channel only" rule).
-- No Taylor's Version exists for this album, so there's nothing to
-- borrow/label here.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=GkD20ajVxnY' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Tim McGraw'); -- Tim McGraw
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=yCMqcFAigRg' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Picture to Burn'); -- Picture to Burn
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=xKCek6_dB0M' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Teardrops on My Guitar'); -- Teardrops on My Guitar
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=v9bxXO9fj98' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = "Should've Said No"); -- Should've Said No
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Jb2stN7kH28' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Our Song'); -- Our Song
