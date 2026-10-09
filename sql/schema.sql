-- Taylor Swift Catalogue — full schema.
--
-- To rebuild the database from scratch:
--   1. CREATE DATABASE taylor_swift_db;
--   2. mysql taylor_swift_db < sql/schema.sql
--      This already includes everything sql/0001_add_album_tracks_edition.sql,
--      sql/0002_add_recordings_music_video_url.sql,
--      sql/0003_add_themes.sql, and sql/0004_add_eras.sql — those
--      files are kept only as a historical record of when each
--      change was introduced; don't run them against a database
--      built from this file, or you'll get a "duplicate column"/
--      "table already exists" error.
--   3. mysql taylor_swift_db < sql/0000_core_artists.sql
--      Bootstraps Taylor Swift, Max Martin, Shellback, and Nathan
--      Chapman — the only artists no dated seed file ever inserts
--      fresh (every one of them just looks these four up by name).
--   4. Run every other sql/*.sql seed/data file, in filename order
--      (they're dated by the album's release year/month, e.g.
--      sql/2006_taylor_swift_debut.sql before sql/2008_fearless.sql).
--      All cross-references between files are by song/artist name,
--      not by ID, so exact auto-increment values don't need to match
--      any previous run — except that each file does assume the
--      artists it looks up (rather than inserts fresh) already exist,
--      so the relative order matters. Every sql/music_videos_*.sql
--      file must run after its corresponding album data, and
--      sql/eras_seed.sql must run after every dated catalog file
--      (it looks up every studio/Taylor's Version album by title).
--
-- Design notes:
--   - `songs` is the composition (one row per song, regardless of how
--     many times it's been recorded).
--   - `recordings` is a specific recording of a song — the original,
--     a Taylor's Version re-recording, a remix, an acoustic version,
--     etc. (see `version_type`). This is what actually has a
--     duration and (optionally) its own music video.
--   - `albums` + `album_tracks` place recordings onto specific
--     albums/tracklists. `album_tracks.edition` tags a track as
--     belonging to a bonus tier (e.g. 'Deluxe Edition', 'From the
--     Vault') without needing a separate album row per edition.
--   - `eras` groups a studio album with its Taylor's Version
--     re-recording as one unit (e.g. "1989" and "1989 (Taylor's
--     Version)" are both the 1989 era) — the grouping that actually
--     matters to Taylor Swift and her fans, distinct from the
--     album-level `album_type`. `albums.era_id` is nullable since
--     standalone singles/soundtrack songs don't belong to any era.
--   - `artists` + the two junction tables credit songwriters and
--     producers per recording (not per song — credits can differ
--     between the original and a re-recording).
--   - `themes` + `recording_themes` tag each recording with free-form
--     mood/theme words (e.g. "heartbreak", "nostalgia") for the
--     search-by-theme / playlist-suggestion feature. Deliberately per
--     recording rather than per song, same reasoning as credits: a
--     10-minute extended cut or an acoustic take can read differently
--     from the original even though the underlying song is the same.

DROP TABLE IF EXISTS `recording_themes`;
DROP TABLE IF EXISTS `themes`;
DROP TABLE IF EXISTS `recording_producers`;
DROP TABLE IF EXISTS `recording_songwriters`;
DROP TABLE IF EXISTS `album_tracks`;
DROP TABLE IF EXISTS `recordings`;
DROP TABLE IF EXISTS `albums`;
DROP TABLE IF EXISTS `eras`;
DROP TABLE IF EXISTS `songs`;
DROP TABLE IF EXISTS `artists`;

CREATE TABLE `artists` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `songs` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `original_release_year` year DEFAULT NULL,
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `eras` (
  `era_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`era_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `albums` (
  `album_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `release_date` date DEFAULT NULL,
  `album_type` enum('studio','deluxe','taylors_version','single','soundtrack','live','other') DEFAULT NULL,
  `era_id` int DEFAULT NULL,
  `cover_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `era_id` (`era_id`),
  CONSTRAINT `albums_ibfk_era` FOREIGN KEY (`era_id`) REFERENCES `eras` (`era_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `recordings` (
  `recording_id` int NOT NULL AUTO_INCREMENT,
  `song_id` int NOT NULL,
  `version_type` enum('original','taylors_version','live','remix','acoustic','demo','other') NOT NULL,
  `duration_seconds` int DEFAULT NULL,
  `music_video_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`recording_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `recordings_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `album_tracks` (
  `album_id` int NOT NULL,
  `recording_id` int NOT NULL,
  `track_number` int NOT NULL,
  `disc_number` int DEFAULT '1',
  `edition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`album_id`,`recording_id`),
  KEY `recording_id` (`recording_id`),
  CONSTRAINT `album_tracks_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`),
  CONSTRAINT `album_tracks_ibfk_2` FOREIGN KEY (`recording_id`) REFERENCES `recordings` (`recording_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `recording_songwriters` (
  `recording_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`recording_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `recording_songwriters_ibfk_1` FOREIGN KEY (`recording_id`) REFERENCES `recordings` (`recording_id`),
  CONSTRAINT `recording_songwriters_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `recording_producers` (
  `recording_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`recording_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `recording_producers_ibfk_1` FOREIGN KEY (`recording_id`) REFERENCES `recordings` (`recording_id`),
  CONSTRAINT `recording_producers_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `themes` (
  `theme_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `recording_themes` (
  `recording_id` int NOT NULL,
  `theme_id` int NOT NULL,
  PRIMARY KEY (`recording_id`, `theme_id`),
  KEY `theme_id` (`theme_id`),
  CONSTRAINT `recording_themes_ibfk_1` FOREIGN KEY (`recording_id`) REFERENCES `recordings` (`recording_id`),
  CONSTRAINT `recording_themes_ibfk_2` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
