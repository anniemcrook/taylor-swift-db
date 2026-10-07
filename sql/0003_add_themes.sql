-- Schema change: free-form theme/mood tags, attached per recording
-- (not per song) since a different take of the same song can read
-- differently — e.g. "All Too Well (10 Minute Version)" carries more
-- "resentment" than the original's "heartbreak", and an acoustic
-- version can feel more "intimate" than the full-band original.
--
-- `themes.name` is free-form (no fixed vocabulary), but UNIQUE to
-- prevent the kind of duplicate-row bug found and fixed on `artists`
-- (the duplicate "Sounwave" row) — every insert should look up the
-- theme by name first and only create it if missing.

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
