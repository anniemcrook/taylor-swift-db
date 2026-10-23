-- Schema change: user accounts. First real server-side user data in
-- this project — everything before this (favourites, tournament
-- progress, playlists) lives entirely in the visitor's own browser.
--
-- `email` is UNIQUE (learned from the Sounwave duplicate-artist bug
-- and every table since: if a column is meant to identify a row
-- uniquely, say so with a constraint, don't just rely on the
-- application code to behave).
--
-- Passwords are never stored directly — `password_hash` holds the
-- output of PHP's `password_hash()` (bcrypt by default), checked
-- with `password_verify()`. Nothing in this schema or codebase
-- stores or logs a plaintext password at any point.

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
