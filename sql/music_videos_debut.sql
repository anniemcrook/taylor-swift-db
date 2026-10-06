-- Music video data: Taylor Swift (2006 debut). All 5 singles had
-- official music videos; every URL verified via YouTube's oEmbed
-- endpoint to confirm it's on @TaylorSwift's own channel, not a fan
-- reupload (several top search hits for these were from channels
-- like "seara31" or the label's own "@BigMachine" channel, neither
-- of which count per the "her channel only" rule).
-- No Taylor's Version exists for this album, so there's nothing to
-- borrow/label here.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=GkD20ajVxnY' WHERE recording_id = 120; -- Tim McGraw
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=yCMqcFAigRg' WHERE recording_id = 121; -- Picture to Burn
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=xKCek6_dB0M' WHERE recording_id = 122; -- Teardrops on My Guitar
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=v9bxXO9fj98' WHERE recording_id = 128; -- Should've Said No
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Jb2stN7kH28' WHERE recording_id = 130; -- Our Song
