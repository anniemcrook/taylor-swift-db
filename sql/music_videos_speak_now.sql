-- Music video data: Speak Now era. 6 original singles had official
-- music videos; every URL verified via YouTube's oEmbed endpoint to
-- confirm it's on @TaylorSwift's own channel. A "The Story Of Us
-- (Taylor's Version)" result initially looked promising but turned
-- out to be from a fan channel ("@wavesandelse") — the TV
-- re-recording never actually got its own video, so it's left NULL
-- here and will correctly borrow/label the original's via the
-- existing tracklist.php logic, same as every other Speak Now TV
-- re-recording.

UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=XPBwXKgDTdE' WHERE recording_id = 176; -- Mine
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=oKar-tF__ac' WHERE recording_id = 177; -- Sparks Fly
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=QUwxKWT6m7U' WHERE recording_id = 178; -- Back to December
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=jYa1eI1hpDE' WHERE recording_id = 181; -- Mean
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=nN6VR92V70M' WHERE recording_id = 182; -- The Story of Us
UPDATE recordings SET music_video_url = 'https://www.youtube.com/watch?v=LZ34LlaIk88' WHERE recording_id = 190; -- Ours
