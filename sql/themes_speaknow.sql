-- Theme/mood data: Speak Now + Speak Now (Taylor's Version).
-- Same caveat as every themes_*.sql file: my own reading of each
-- song, not externally verified.
--
-- 17 songs shared between both versions get the same tags on both
-- the original and Taylor's Version recording. "If This Was a
-- Movie" only exists on the original (not re-recorded for TV); the
-- 6 vault tracks only exist on the TV edition. The standalone
-- acoustic/remix bonus recordings (Back to December acoustic,
-- Haunted acoustic, Mine remix) aren't separately tagged — they're
-- alternate takes of songs already covered above, and Moods matches
-- by song, not recording.

INSERT INTO themes (name) VALUES
    ('commitment'), ('temptation'), ('infatuation'), ('defiance'),
    ('bullying'), ('triumph'), ('miscommunication'), ('bittersweetness'),
    ('wonder'), ('jealousy'), ('manipulation'), ('forgiveness'),
    ('compassion'), ('desperation'), ('fear'), ('excitement'),
    ('vulnerability'), ('anticipation'), ('insecurity')
ON DUPLICATE KEY UPDATE name = name;

SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_commitment    := (SELECT theme_id FROM themes WHERE name = 'commitment');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_apology       := (SELECT theme_id FROM themes WHERE name = 'apology');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_manipulation  := (SELECT theme_id FROM themes WHERE name = 'manipulation');
SET @t_resilience    := (SELECT theme_id FROM themes WHERE name = 'resilience');
SET @t_bullying      := (SELECT theme_id FROM themes WHERE name = 'bullying');
SET @t_triumph       := (SELECT theme_id FROM themes WHERE name = 'triumph');
SET @t_miscommunication := (SELECT theme_id FROM themes WHERE name = 'miscommunication');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_frustration   := (SELECT theme_id FROM themes WHERE name = 'frustration');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_childhood     := (SELECT theme_id FROM themes WHERE name = 'childhood');
SET @t_bittersweet   := (SELECT theme_id FROM themes WHERE name = 'bittersweetness');
SET @t_wonder        := (SELECT theme_id FROM themes WHERE name = 'wonder');
SET @t_anger         := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_jealousy      := (SELECT theme_id FROM themes WHERE name = 'jealousy');
SET @t_revenge       := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_forgiveness   := (SELECT theme_id FROM themes WHERE name = 'forgiveness');
SET @t_compassion    := (SELECT theme_id FROM themes WHERE name = 'compassion');
SET @t_growing_up    := (SELECT theme_id FROM themes WHERE name = 'growing up');
SET @t_desperation   := (SELECT theme_id FROM themes WHERE name = 'desperation');
SET @t_fear          := (SELECT theme_id FROM themes WHERE name = 'fear');
SET @t_loss          := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_belonging     := (SELECT theme_id FROM themes WHERE name = 'belonging');
SET @t_admiration    := (SELECT theme_id FROM themes WHERE name = 'admiration');
SET @t_waiting       := (SELECT theme_id FROM themes WHERE name = 'waiting');
SET @t_excitement    := (SELECT theme_id FROM themes WHERE name = 'excitement');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_friendship    := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_anticipation  := (SELECT theme_id FROM themes WHERE name = 'anticipation');
SET @t_insecurity    := (SELECT theme_id FROM themes WHERE name = 'insecurity');
SET @t_loneliness    := (SELECT theme_id FROM themes WHERE name = 'loneliness');
SET @t_hindsight     := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');

-- 1. Mine
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mine'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mine'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_hope), (@o, @t_commitment),
    (@t, @t_romance), (@t, @t_hope), (@t, @t_commitment);

-- 2. Sparks Fly
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sparks Fly'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sparks Fly'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_desire), (@o, @t_infatuation), (@o, @t_temptation),
    (@t, @t_desire), (@t, @t_infatuation), (@t, @t_temptation);

-- 3. Back to December
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Back to December'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Back to December'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_regret), (@o, @t_apology), (@o, @t_longing),
    (@t, @t_regret), (@t, @t_apology), (@t, @t_longing);

-- 4. Speak Now
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Speak Now'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Speak Now'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_defiance), (@o, @t_hope),
    (@t, @t_romance), (@t, @t_defiance), (@t, @t_hope);

-- 5. Dear John
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Dear John'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Dear John'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_betrayal), (@o, @t_manipulation), (@o, @t_regret),
    (@t, @t_betrayal), (@t, @t_manipulation), (@t, @t_regret);

-- 6. Mean
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mean'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mean'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_resilience), (@o, @t_bullying), (@o, @t_triumph),
    (@t, @t_resilience), (@t, @t_bullying), (@t, @t_triumph);

-- 7. The Story of Us
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Story of Us'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Story of Us'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_miscommunication), (@o, @t_heartbreak), (@o, @t_frustration),
    (@t, @t_miscommunication), (@t, @t_heartbreak), (@t, @t_frustration);

-- 8. Never Grow Up
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Never Grow Up'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Never Grow Up'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_nostalgia), (@o, @t_childhood), (@o, @t_bittersweet),
    (@t, @t_nostalgia), (@t, @t_childhood), (@t, @t_bittersweet);

-- 9. Enchanted
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Enchanted'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Enchanted'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_infatuation), (@o, @t_wonder), (@o, @t_hope),
    (@t, @t_infatuation), (@t, @t_wonder), (@t, @t_hope);

-- 10. Better than Revenge
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Better than Revenge'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Better than Revenge'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_anger), (@o, @t_jealousy), (@o, @t_revenge),
    (@t, @t_anger), (@t, @t_jealousy), (@t, @t_revenge);

-- 11. Innocent
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Innocent'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Innocent'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_forgiveness), (@o, @t_compassion), (@o, @t_growing_up),
    (@t, @t_forgiveness), (@t, @t_compassion), (@t, @t_growing_up);

-- 12. Haunted
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Haunted'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Haunted'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_desperation), (@o, @t_fear), (@o, @t_heartbreak),
    (@t, @t_desperation), (@t, @t_fear), (@t, @t_heartbreak);

-- 13. Last Kiss
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Last Kiss'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Last Kiss'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_heartbreak), (@o, @t_nostalgia), (@o, @t_loss),
    (@t, @t_heartbreak), (@t, @t_nostalgia), (@t, @t_loss);

-- 14. Long Live
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Long Live'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Long Live'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_triumph), (@o, @t_gratitude), (@o, @t_nostalgia),
    (@t, @t_triumph), (@t, @t_gratitude), (@t, @t_nostalgia);

-- 15. Ours
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Ours'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Ours'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_defiance), (@o, @t_belonging),
    (@t, @t_romance), (@t, @t_defiance), (@t, @t_belonging);

-- 16. If This Was a Movie (original only — not re-recorded for TV)
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'If This Was a Movie'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_heartbreak), (@o, @t_hope);

-- 17. Superman
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Superman'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Superman'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_admiration), (@o, @t_waiting), (@o, @t_longing),
    (@t, @t_admiration), (@t, @t_waiting), (@t, @t_longing);

-- 18-23: From the Vault, exclusive to the TV edition.

-- 18. Electric Touch
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Electric Touch'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_desire), (@t, @t_excitement), (@t, @t_vulnerability);

-- 19. When Emma Falls in Love
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'When Emma Falls in Love'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_admiration), (@t, @t_friendship), (@t, @t_wonder);

-- 20. I Can See You
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Can See You'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_longing), (@t, @t_desire), (@t, @t_anticipation);

-- 21. Castles Crumbling
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Castles Crumbling'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_insecurity), (@t, @t_fear), (@t, @t_loneliness);

-- 22. Foolish One
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Foolish One'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_hindsight), (@t, @t_infatuation), (@t, @t_self_disc);

-- 23. Timeless
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Timeless'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_romance), (@t, @t_nostalgia), (@t, @t_longing);
