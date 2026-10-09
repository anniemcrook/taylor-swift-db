-- Non-album singles and soundtrack songs: standalone Taylor Swift
-- releases that were never part of a numbered studio album. The
-- schema already anticipated this (`albums.album_type` includes
-- 'single' and 'soundtrack'), so no migration is needed — each one
-- gets its own one-track "album" row, same as how streaming
-- services list a standalone single.
--
-- All songwriter/producer credits and durations below are sourced
-- from Wikipedia and news coverage, cross-checked across multiple
-- sources, same standard as the rest of this catalog. Chronological
-- order, earliest release first.
--
-- `artists` has no UNIQUE constraint on `name` (unlike `themes`),
-- so new artists are inserted with an explicit NOT EXISTS guard
-- rather than `ON DUPLICATE KEY UPDATE` — this is exactly the gap
-- that caused the earlier Sounwave duplicate-artist bug, so this
-- is deliberate, not an oversight.

INSERT INTO artists (name)
SELECT 'T Bone Burnett' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'T Bone Burnett');

INSERT INTO artists (name)
SELECT 'Joy Williams' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'Joy Williams');

INSERT INTO artists (name)
SELECT 'John Paul White' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'John Paul White');

INSERT INTO artists (name)
SELECT 'Andrew Lloyd Webber' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'Andrew Lloyd Webber');

INSERT INTO artists (name)
SELECT 'Greg Wells' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'Greg Wells');

INSERT INTO artists (name)
SELECT 'Tom Hooper' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'Tom Hooper');

INSERT INTO artists (name)
SELECT 'Jimmy Napes' FROM (SELECT 1) AS dummy
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE name = 'Jimmy Napes');

-- 1. Crazier (Hannah Montana: The Movie, 2009)
-- Writers: Taylor Swift, Robert Ellis Orrall. Producer: Nathan Chapman.
INSERT INTO albums (title, release_date, album_type) VALUES ('Crazier', '2009-03-24', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Crazier', 2009);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 192);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Robert Ellis Orrall'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman'));

-- 2. Safe & Sound (The Hunger Games: Songs from District 12 and
-- Beyond, 2011) — with The Civil Wars (Joy Williams, John Paul White).
-- Writers: Taylor Swift, Joy Williams, John Paul White, T Bone Burnett.
-- Producer: T Bone Burnett.
INSERT INTO albums (title, release_date, album_type) VALUES ('Safe & Sound', '2011-12-26', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Safe & Sound', 2011);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 241);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Joy Williams')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'John Paul White')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'T Bone Burnett'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'T Bone Burnett'));

-- 3. Eyes Open (The Hunger Games: Songs from District 12 and
-- Beyond, 2012). Writer: Taylor Swift. Producers: Taylor Swift,
-- Nathan Chapman.
INSERT INTO albums (title, release_date, album_type) VALUES ('Eyes Open', '2012-03-27', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Eyes Open', 2012);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 244);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Nathan Chapman'));

-- 4. Sweeter than Fiction (One Chance: Motion Picture Soundtrack, 2013)
-- Writers/producers: Taylor Swift, Jack Antonoff.
INSERT INTO albums (title, release_date, album_type) VALUES ('Sweeter than Fiction', '2013-10-21', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Sweeter than Fiction', 2013);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 234);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff'));

-- 5. Beautiful Ghosts (Cats, 2019). Writers: Taylor Swift, Andrew
-- Lloyd Webber. Producers: Greg Wells, Andrew Lloyd Webber, Tom Hooper.
INSERT INTO albums (title, release_date, album_type) VALUES ('Beautiful Ghosts', '2019-11-15', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Beautiful Ghosts', 2019);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 261);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Andrew Lloyd Webber'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Greg Wells')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Andrew Lloyd Webber')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Tom Hooper'));

-- 6. Christmas Tree Farm (standalone holiday single, 2019). Writer:
-- Taylor Swift. Producers: Taylor Swift, Jimmy Napes.
INSERT INTO albums (title, release_date, album_type) VALUES ('Christmas Tree Farm', '2019-12-06', 'single');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Christmas Tree Farm', 2019);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 227);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Jimmy Napes'));

-- 7. Only the Young (accompanies the Miss Americana documentary, 2020)
-- Writers/producers: Taylor Swift, Joel Little.
INSERT INTO albums (title, release_date, album_type) VALUES ('Only the Young', '2020-01-31', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Only the Young', 2020);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 157);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Joel Little'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Joel Little'));

-- 8. Carolina (Where the Crawdads Sing, 2022). Writer: Taylor Swift
-- (solo). Producers: Taylor Swift, Aaron Dessner.
INSERT INTO albums (title, release_date, album_type) VALUES ('Carolina', '2022-06-24', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('Carolina', 2022);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 264);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Aaron Dessner'));

-- 9. I Knew It, I Knew You (Toy Story 5, 2026). Writers: Taylor
-- Swift, Jack Antonoff. Producer: Jack Antonoff.
INSERT INTO albums (title, release_date, album_type) VALUES ('I Knew It, I Knew You', '2026-06-05', 'soundtrack');
SET @album_id := LAST_INSERT_ID();
INSERT INTO songs (title, original_release_year) VALUES ('I Knew It, I Knew You', 2026);
SET @song_id := LAST_INSERT_ID();
INSERT INTO recordings (song_id, version_type, duration_seconds) VALUES (@song_id, 'original', 178);
SET @recording_id := LAST_INSERT_ID();
INSERT INTO album_tracks (album_id, recording_id, track_number) VALUES (@album_id, @recording_id, 1);
INSERT INTO recording_songwriters (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Taylor Swift')),
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff'));
INSERT INTO recording_producers (recording_id, artist_id) VALUES
    (@recording_id, (SELECT artist_id FROM artists WHERE name = 'Jack Antonoff'));
