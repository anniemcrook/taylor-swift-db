-- Theme/mood data: Fearless + Fearless (Taylor's Version), as the
-- trial run for the Moods feature. Tags are my own reading of each
-- song's content, based on general knowledge of the lyrics/public
-- commentary — unlike every other seed file in this project, there's
-- no single authoritative source to verify these against, so treat
-- them as a considered first draft rather than ground truth.
--
-- Shared songs get the same tags on both the original and Taylor's
-- Version recording (the lyrics didn't change), entered separately
-- per the project's "tag per recording, not per song" design.
--
-- `INSERT ... ON DUPLICATE KEY UPDATE name=name` is a no-op upsert:
-- it creates the theme row if missing, and does nothing (not an
-- error) if it already exists, relying on the UNIQUE constraint on
-- themes.name — this is how every theme gets created exactly once no
-- matter how many files/tracks reference it.

INSERT INTO themes (name) VALUES
    ('leap of faith'), ('hope'), ('romance'), ('coming of age'), ('friendship'),
    ('hindsight'), ('forbidden love'), ('fairy tale'), ('crush'), ('admiration'),
    ('disillusionment'), ('heartbreak'), ('growing up'), ('unrequited love'), ('longing'),
    ('loss'), ('moving on'), ('frustration'), ('breakup'), ('confusion'),
    ('betrayal'), ('anger'), ('nostalgia'), ('contrast'), ('childhood'),
    ('family'), ('gratitude'), ('perseverance'), ('resilience'), ('young love'),
    ('trust'), ('desire'), ('waiting'), ('regret'), ('apology'),
    ('new love'), ('resentment'), ('bitterness'), ('facade'), ('reconciliation'),
    ('missed connection'), ('farewell')
ON DUPLICATE KEY UPDATE name = name;

SET @t_leap_of_faith     := (SELECT theme_id FROM themes WHERE name = 'leap of faith');
SET @t_hope              := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_romance           := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_coming_of_age     := (SELECT theme_id FROM themes WHERE name = 'coming of age');
SET @t_friendship        := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_hindsight         := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_forbidden_love    := (SELECT theme_id FROM themes WHERE name = 'forbidden love');
SET @t_fairy_tale        := (SELECT theme_id FROM themes WHERE name = 'fairy tale');
SET @t_crush             := (SELECT theme_id FROM themes WHERE name = 'crush');
SET @t_admiration        := (SELECT theme_id FROM themes WHERE name = 'admiration');
SET @t_disillusionment   := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_heartbreak        := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_growing_up        := (SELECT theme_id FROM themes WHERE name = 'growing up');
SET @t_unrequited_love   := (SELECT theme_id FROM themes WHERE name = 'unrequited love');
SET @t_longing           := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_loss              := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_moving_on         := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_frustration       := (SELECT theme_id FROM themes WHERE name = 'frustration');
SET @t_breakup           := (SELECT theme_id FROM themes WHERE name = 'breakup');
SET @t_confusion         := (SELECT theme_id FROM themes WHERE name = 'confusion');
SET @t_betrayal          := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_anger             := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_nostalgia         := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_contrast          := (SELECT theme_id FROM themes WHERE name = 'contrast');
SET @t_childhood         := (SELECT theme_id FROM themes WHERE name = 'childhood');
SET @t_family            := (SELECT theme_id FROM themes WHERE name = 'family');
SET @t_gratitude         := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_perseverance      := (SELECT theme_id FROM themes WHERE name = 'perseverance');
SET @t_resilience        := (SELECT theme_id FROM themes WHERE name = 'resilience');
SET @t_young_love        := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_trust             := (SELECT theme_id FROM themes WHERE name = 'trust');
SET @t_desire            := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_waiting           := (SELECT theme_id FROM themes WHERE name = 'waiting');
SET @t_regret            := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_apology           := (SELECT theme_id FROM themes WHERE name = 'apology');
SET @t_new_love          := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_resentment        := (SELECT theme_id FROM themes WHERE name = 'resentment');
SET @t_bitterness        := (SELECT theme_id FROM themes WHERE name = 'bitterness');
SET @t_facade            := (SELECT theme_id FROM themes WHERE name = 'facade');
SET @t_reconciliation    := (SELECT theme_id FROM themes WHERE name = 'reconciliation');
SET @t_missed_connection := (SELECT theme_id FROM themes WHERE name = 'missed connection');
SET @t_farewell          := (SELECT theme_id FROM themes WHERE name = 'farewell');

-- 1. Fearless
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fearless'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fearless'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_leap_of_faith), (@o, @t_hope), (@o, @t_romance),
    (@t, @t_leap_of_faith), (@t, @t_hope), (@t, @t_romance);

-- 2. Fifteen
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fifteen'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Fifteen'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_coming_of_age), (@o, @t_friendship), (@o, @t_hindsight),
    (@t, @t_coming_of_age), (@t, @t_friendship), (@t, @t_hindsight);

-- 3. Love Story
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Love Story'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Love Story'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_forbidden_love), (@o, @t_fairy_tale), (@o, @t_romance),
    (@t, @t_forbidden_love), (@t, @t_fairy_tale), (@t, @t_romance);

-- 4. Hey Stephen
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Hey Stephen'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Hey Stephen'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_crush), (@o, @t_admiration),
    (@t, @t_crush), (@t, @t_admiration);

-- 5. White Horse
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'White Horse'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'White Horse'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_disillusionment), (@o, @t_heartbreak), (@o, @t_growing_up),
    (@t, @t_disillusionment), (@t, @t_heartbreak), (@t, @t_growing_up);

-- 6. You Belong with Me
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Belong with Me'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Belong with Me'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_unrequited_love), (@o, @t_friendship), (@o, @t_longing),
    (@t, @t_unrequited_love), (@t, @t_friendship), (@t, @t_longing);

-- 7. Breathe
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Breathe'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Breathe'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_heartbreak), (@o, @t_loss), (@o, @t_moving_on),
    (@t, @t_heartbreak), (@t, @t_loss), (@t, @t_moving_on);

-- 8. Tell Me Why
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Tell Me Why'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Tell Me Why'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_frustration), (@o, @t_breakup), (@o, @t_confusion),
    (@t, @t_frustration), (@t, @t_breakup), (@t, @t_confusion);

-- 9. You're Not Sorry
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = "You're Not Sorry"));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = "You're Not Sorry"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_betrayal), (@o, @t_heartbreak), (@o, @t_anger),
    (@t, @t_betrayal), (@t, @t_heartbreak), (@t, @t_anger);

-- 10. The Way I Loved You
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Way I Loved You'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Way I Loved You'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_nostalgia), (@o, @t_longing), (@o, @t_contrast),
    (@t, @t_nostalgia), (@t, @t_longing), (@t, @t_contrast);

-- 11. Forever & Always
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Forever & Always'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Forever & Always'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_betrayal), (@o, @t_heartbreak), (@o, @t_confusion),
    (@t, @t_betrayal), (@t, @t_heartbreak), (@t, @t_confusion);

-- 12. The Best Day
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Best Day'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Best Day'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_childhood), (@o, @t_family), (@o, @t_gratitude), (@o, @t_nostalgia),
    (@t, @t_childhood), (@t, @t_family), (@t, @t_gratitude), (@t, @t_nostalgia);

-- 13. Change
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Change'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Change'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_hope), (@o, @t_perseverance), (@o, @t_resilience),
    (@t, @t_hope), (@t, @t_perseverance), (@t, @t_resilience);

-- 14. Jump Then Fall
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Jump Then Fall'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Jump Then Fall'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_young_love), (@o, @t_trust), (@o, @t_romance),
    (@t, @t_young_love), (@t, @t_trust), (@t, @t_romance);

-- 15. Untouchable
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Untouchable'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Untouchable'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_desire), (@o, @t_romance),
    (@t, @t_longing), (@t, @t_desire), (@t, @t_romance);

-- 16. Forever & Always (Piano Version)
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Forever & Always (Piano Version)'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Forever & Always (Piano Version)'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_betrayal), (@o, @t_heartbreak), (@o, @t_confusion),
    (@t, @t_betrayal), (@t, @t_heartbreak), (@t, @t_confusion);

-- 17. Come In with the Rain
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Come In with the Rain'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Come In with the Rain'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_waiting), (@o, @t_heartbreak),
    (@t, @t_longing), (@t, @t_waiting), (@t, @t_heartbreak);

-- 18. Superstar
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Superstar'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Superstar'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_unrequited_love), (@o, @t_admiration), (@o, @t_longing),
    (@t, @t_unrequited_love), (@t, @t_admiration), (@t, @t_longing);

-- 19. The Other Side of the Door
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Other Side of the Door'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Other Side of the Door'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_regret), (@o, @t_apology), (@o, @t_romance),
    (@t, @t_regret), (@t, @t_apology), (@t, @t_romance);

-- 20-26: From the Vault / bonus tracks exclusive to the TV edition.

-- 20. Today Was a Fairytale
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Today Was a Fairytale'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_romance), (@t, @t_fairy_tale), (@t, @t_new_love);

-- 21. You All Over Me
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'You All Over Me'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_heartbreak), (@t, @t_moving_on), (@t, @t_resentment);

-- 22. Mr. Perfectly Fine
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mr. Perfectly Fine'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_heartbreak), (@t, @t_bitterness), (@t, @t_facade);

-- 23. We Were Happy
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'We Were Happy'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_nostalgia), (@t, @t_loss), (@t, @t_regret);

-- 24. That's When
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = "That's When"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_reconciliation), (@t, @t_hope), (@t, @t_romance);

-- 25. Don't You
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = "Don't You"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_regret), (@t, @t_longing), (@t, @t_missed_connection);

-- 26. Bye Bye Baby
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bye Bye Baby'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_heartbreak), (@t, @t_farewell), (@t, @t_moving_on);
