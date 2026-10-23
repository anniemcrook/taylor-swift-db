-- User-contributed theme tags, additive to the curator-assigned
-- `recording_themes`. One row = one user applying one theme to one
-- song; a theme's "vote count" is just how many rows share it.
-- Deliberately keyed by song (not recording) since users think of a
-- song as one thing, not six separate recordings of it — distinct
-- from `recording_themes`, which is per-recording on purpose.
CREATE TABLE `user_song_themes` (
  `user_id` int NOT NULL,
  `song_id` int NOT NULL,
  `theme_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `song_id`, `theme_id`),
  KEY `song_id` (`song_id`, `theme_id`),
  KEY `theme_id` (`theme_id`),
  CONSTRAINT `user_song_themes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_song_themes_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`),
  CONSTRAINT `user_song_themes_ibfk_3` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
