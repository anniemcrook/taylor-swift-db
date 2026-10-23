-- Cross-device sync for Favourites, Playlists, and completed
-- Tournament results, for logged-in users. The in-progress
-- Tournament bracket itself (mid-play state, undo history) stays
-- local-only even while logged in — only the finished ranked result
-- is ever stored here. See backend/api/ for the endpoints that
-- read/write these tables, and backend/*.js for how each feature
-- switches between localStorage (logged out) and these tables
-- (logged in).

CREATE TABLE `user_favourites` (
  `user_id` int NOT NULL,
  `song_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `song_id`),
  CONSTRAINT `user_favourites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_favourites_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_playlists` (
  `playlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `source` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`playlist_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_playlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Ordered by `position` (0-based). Stored by song_id, not
-- recording_id — matches how the existing localStorage playlists
-- work (position, not song_id, is what disambiguates two entries
-- sharing a song_id, e.g. an original and a Taylor's Version). Title/
-- album/duration are looked up live from the catalogue at render
-- time rather than snapshotted, consistent with every other page.
CREATE TABLE `user_playlist_songs` (
  `playlist_id` int NOT NULL,
  `position` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`playlist_id`, `position`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `user_playlist_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `user_playlists` (`playlist_id`),
  CONSTRAINT `user_playlist_songs_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tournament_results` (
  `tournament_result_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `completed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tournament_result_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tournament_results_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- By recording_id, not song_id — the Tournament pits specific
-- recordings against each other (original vs. Taylor's Version are
-- separate entrants), and the planned stats feature needs that
-- precision to roll results up to albums.
CREATE TABLE `tournament_result_rankings` (
  `tournament_result_id` int NOT NULL,
  `rank` int NOT NULL,
  `recording_id` int NOT NULL,
  PRIMARY KEY (`tournament_result_id`, `rank`),
  KEY `recording_id` (`recording_id`),
  CONSTRAINT `tournament_result_rankings_ibfk_1` FOREIGN KEY (`tournament_result_id`) REFERENCES `tournament_results` (`tournament_result_id`),
  CONSTRAINT `tournament_result_rankings_ibfk_2` FOREIGN KEY (`recording_id`) REFERENCES `recordings` (`recording_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
