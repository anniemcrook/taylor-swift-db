-- Era data + backfill: run after sql/0004_add_eras.sql and after
-- every album in the catalog already exists (this just looks up
-- albums by title, same cross-reference-by-name convention as
-- every other seed file).
--
-- `icon` is the colored heart fans and Taylor Nation use for each
-- era on social media (verified via web search, not guessed) — the
-- one exception is The Life of a Showgirl, which uses the "heart on
-- fire" emoji rather than a plain colored heart.
--
-- `eras.name` is UNIQUE, so this is safe to re-run.

INSERT INTO eras (name, icon) VALUES
    ('Taylor Swift', '💚'),
    ('Fearless', '💛'),
    ('Speak Now', '💜'),
    ('Red', '❤️'),
    ('1989', '🩵'),
    ('reputation', '🖤'),
    ('Lover', '🩷'),
    ('folklore', '🩶'),
    ('evermore', '🤎'),
    ('Midnights', '💙'),
    ('The Tortured Poets Department', '🤍'),
    ('The Life of a Showgirl', '❤️‍🔥')
ON DUPLICATE KEY UPDATE icon = VALUES(icon);

UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Taylor Swift') WHERE title = 'Taylor Swift';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Fearless') WHERE title IN ('Fearless', "Fearless (Taylor's Version)");
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Speak Now') WHERE title IN ('Speak Now', "Speak Now (Taylor's Version)");
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Red') WHERE title IN ('Red', "Red (Taylor's Version)");
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = '1989') WHERE title IN ('1989', "1989 (Taylor's Version)");
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'reputation') WHERE title = 'reputation';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Lover') WHERE title = 'Lover';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'folklore') WHERE title = 'folklore';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'evermore') WHERE title = 'evermore';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'Midnights') WHERE title = 'Midnights';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'The Tortured Poets Department') WHERE title = 'The Tortured Poets Department';
UPDATE albums SET era_id = (SELECT era_id FROM eras WHERE name = 'The Life of a Showgirl') WHERE title = 'The Life of a Showgirl';
