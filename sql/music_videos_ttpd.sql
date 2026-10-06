-- Music video data: The Tortured Poets Department. 2 full official
-- music videos (verified via oEmbed to be on @TaylorSwift): "Fortnight"
-- (feat. Post Malone) and "I Can Do It With a Broken Heart". "Fresh
-- Out the Slammer" and "But Daddy I Love Him" were notable singles
-- but only ever got lyric videos. No Anthology track got a full music
-- video either (thanK you aIMee, The Prophecy, Who's Afraid of Little
-- Old Me? are lyric-video only). No Taylor's Version exists for this
-- album.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=q3zqJs7JUCQ' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fortnight'); -- Fortnight (feat. Post Malone)
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=Sl6en1NPTYM' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Can Do It With a Broken Heart'); -- I Can Do It With a Broken Heart
