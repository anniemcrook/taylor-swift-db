-- Schema change: track each recording's own official music video
-- (if one exists), so the tracklist page can show a link, and — for
-- a Taylor's Version (or other re-recording) that never got its own
-- video — borrow the original recording's video and label it clearly
-- as belonging to that other version.
-- NULL = no official music video for this specific recording.

ALTER TABLE recordings
  ADD COLUMN music_video_url VARCHAR(500) DEFAULT NULL;
