-- Schema change: tag bonus/platinum/vault tracks without needing a
-- separate album row for each edition.
-- NULL = part of the main/standard tracklist.
-- Non-NULL = a short label like 'Platinum Edition' or 'From the Vault'.

ALTER TABLE album_tracks
  ADD COLUMN edition VARCHAR(50) DEFAULT NULL AFTER disc_number;
