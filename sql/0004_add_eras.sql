-- Schema change: group albums into "eras" — the unit that actually
-- matters to Taylor Swift and her fans, where a studio album and
-- its Taylor's Version re-recording are the same era, not two
-- separate entries. Standalone singles/soundtrack songs don't
-- belong to any era, so `albums.era_id` is nullable.
--
-- This file is schema only (same pattern as 0001-0003) — the actual
-- era rows and the era_id backfill onto existing albums live in
-- sql/eras_seed.sql, run after the dated catalog files like any
-- other seed/data file.

CREATE TABLE `eras` (
  `era_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`era_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `albums`
  ADD COLUMN `era_id` int DEFAULT NULL AFTER `album_type`,
  ADD CONSTRAINT `albums_ibfk_era` FOREIGN KEY (`era_id`) REFERENCES `eras` (`era_id`);
