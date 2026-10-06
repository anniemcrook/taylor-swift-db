-- Music video data: Speak Now era. 6 original singles had official
-- music videos; every URL verified via YouTube's oEmbed endpoint to
-- confirm it's on @TaylorSwift's own channel. A "The Story Of Us
-- (Taylor's Version)" result initially looked promising but turned
-- out to be from a fan channel ("@wavesandelse") — the TV
-- re-recording never actually got its own video, so it's left NULL
-- here and will correctly borrow/label the original's via the
-- existing tracklist.php logic, same as every other Speak Now TV
-- re-recording.
--
-- Updates are keyed by (song title, version_type) rather than a
-- hardcoded recording_id, so they work regardless of what IDs come
-- out of a given rebuild.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=XPBwXKgDTdE' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mine'); -- Mine
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=oKar-tF__ac' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sparks Fly'); -- Sparks Fly
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QUwxKWT6m7U' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Back to December'); -- Back to December
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=jYa1eI1hpDE' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mean'); -- Mean
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=nN6VR92V70M' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Story of Us'); -- The Story of Us
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=LZ34LlaIk88' WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Ours'); -- Ours
