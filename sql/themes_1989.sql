-- Theme/mood data: 1989 + 1989 (Taylor's Version).
-- Same caveat as every themes_*.sql file: my own reading of each
-- song, not externally verified.
--
-- 16 songs shared between both versions get the same tags on both
-- the original and Taylor's Version recording. The 5 vault tracks
-- only exist on the TV edition.

INSERT INTO themes (name) VALUES
    ('new beginnings'), ('self-awareness'), ('irony'), ('anxiety'),
    ('relief'), ('paranoia'), ('secrecy'), ('comfort'), ('judgment'),
    ('obsession'), ('humiliation')
ON DUPLICATE KEY UPDATE name = name;

SET @t_new_beginnings := (SELECT theme_id FROM themes WHERE name = 'new beginnings');
SET @t_excitement     := (SELECT theme_id FROM themes WHERE name = 'excitement');
SET @t_hope           := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_self_awareness := (SELECT theme_id FROM themes WHERE name = 'self-awareness');
SET @t_irony          := (SELECT theme_id FROM themes WHERE name = 'irony');
SET @t_romance        := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_desire         := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_passion        := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_longing        := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_anxiety        := (SELECT theme_id FROM themes WHERE name = 'anxiety');
SET @t_relief         := (SELECT theme_id FROM themes WHERE name = 'relief');
SET @t_nostalgia      := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_regret         := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_anger          := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_moving_on      := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_resilience     := (SELECT theme_id FROM themes WHERE name = 'resilience');
SET @t_confidence     := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_carefree       := (SELECT theme_id FROM themes WHERE name = 'carefree');
SET @t_betrayal       := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_revenge        := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_infatuation    := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_bittersweet    := (SELECT theme_id FROM themes WHERE name = 'bittersweetness');
SET @t_reconciliation := (SELECT theme_id FROM themes WHERE name = 'reconciliation');
SET @t_paranoia       := (SELECT theme_id FROM themes WHERE name = 'paranoia');
SET @t_secrecy        := (SELECT theme_id FROM themes WHERE name = 'secrecy');
SET @t_healing        := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_acceptance     := (SELECT theme_id FROM themes WHERE name = 'acceptance');
SET @t_chaos          := (SELECT theme_id FROM themes WHERE name = 'chaos');
SET @t_disillusion    := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_comfort        := (SELECT theme_id FROM themes WHERE name = 'comfort');
SET @t_admiration     := (SELECT theme_id FROM themes WHERE name = 'admiration');
SET @t_friendship     := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_defiance       := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_judgment       := (SELECT theme_id FROM themes WHERE name = 'judgment');
SET @t_desperation    := (SELECT theme_id FROM themes WHERE name = 'desperation');
SET @t_confusion      := (SELECT theme_id FROM themes WHERE name = 'confusion');
SET @t_heartbreak     := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_obsession      := (SELECT theme_id FROM themes WHERE name = 'obsession');
SET @t_young_love     := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_humiliation    := (SELECT theme_id FROM themes WHERE name = 'humiliation');

-- 1. Welcome to New York
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Welcome to New York'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Welcome to New York'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_new_beginnings), (@o, @t_excitement), (@o, @t_hope),
    (@t, @t_new_beginnings), (@t, @t_excitement), (@t, @t_hope);

-- 2. Blank Space
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Blank Space'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Blank Space'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_self_awareness), (@o, @t_irony), (@o, @t_romance),
    (@t, @t_self_awareness), (@t, @t_irony), (@t, @t_romance);

-- 3. Style
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Style'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Style'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_desire), (@o, @t_passion), (@o, @t_longing),
    (@t, @t_desire), (@t, @t_passion), (@t, @t_longing);

-- 4. Out of the Woods
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Out of the Woods'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Out of the Woods'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_anxiety), (@o, @t_relief), (@o, @t_nostalgia),
    (@t, @t_anxiety), (@t, @t_relief), (@t, @t_nostalgia);

-- 5. All You Had to Do Was Stay
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'All You Had to Do Was Stay'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'All You Had to Do Was Stay'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_regret), (@o, @t_anger), (@o, @t_moving_on),
    (@t, @t_regret), (@t, @t_anger), (@t, @t_moving_on);

-- 6. Shake It Off
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Shake It Off'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Shake It Off'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_resilience), (@o, @t_confidence), (@o, @t_carefree),
    (@t, @t_resilience), (@t, @t_confidence), (@t, @t_carefree);

-- 7. I Wish You Would
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Wish You Would'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Wish You Would'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_nostalgia), (@o, @t_regret),
    (@t, @t_longing), (@t, @t_nostalgia), (@t, @t_regret);

-- 8. Bad Blood
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bad Blood'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bad Blood'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_betrayal), (@o, @t_anger), (@o, @t_revenge),
    (@t, @t_betrayal), (@t, @t_anger), (@t, @t_revenge);

-- 9. Wildest Dreams
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Wildest Dreams'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Wildest Dreams'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_infatuation), (@o, @t_bittersweet), (@o, @t_nostalgia),
    (@t, @t_infatuation), (@t, @t_bittersweet), (@t, @t_nostalgia);

-- 10. How You Get the Girl
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'How You Get the Girl'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'How You Get the Girl'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_hope), (@o, @t_romance), (@o, @t_reconciliation),
    (@t, @t_hope), (@t, @t_romance), (@t, @t_reconciliation);

-- 11. This Love
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'This Love'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'This Love'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_longing), (@o, @t_reconciliation),
    (@t, @t_romance), (@t, @t_longing), (@t, @t_reconciliation);

-- 12. I Know Places
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Know Places'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Know Places'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_paranoia), (@o, @t_secrecy),
    (@t, @t_romance), (@t, @t_paranoia), (@t, @t_secrecy);

-- 13. Clean
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Clean'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Clean'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_healing), (@o, @t_moving_on), (@o, @t_acceptance),
    (@t, @t_healing), (@t, @t_moving_on), (@t, @t_acceptance);

-- 14. Wonderland
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Wonderland'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Wonderland'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_chaos), (@o, @t_infatuation), (@o, @t_disillusion),
    (@t, @t_chaos), (@t, @t_infatuation), (@t, @t_disillusion);

-- 15. You Are in Love
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Are in Love'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'You Are in Love'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_comfort), (@o, @t_admiration),
    (@t, @t_romance), (@t, @t_comfort), (@t, @t_admiration);

-- 16. New Romantics
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'New Romantics'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'New Romantics'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_friendship), (@o, @t_resilience), (@o, @t_hope),
    (@t, @t_friendship), (@t, @t_resilience), (@t, @t_hope);

-- 17-21: From the Vault, exclusive to the TV edition.

-- 17. Slut!
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Slut!'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_defiance), (@t, @t_romance), (@t, @t_judgment);

-- 18. Say Don't Go
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Say Don''t Go'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_desperation), (@t, @t_confusion), (@t, @t_heartbreak);

-- 19. Now That We Don't Talk
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Now That We Don''t Talk'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_moving_on), (@t, @t_nostalgia), (@t, @t_relief);

-- 20. Suburban Legends
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Suburban Legends'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_obsession), (@t, @t_young_love), (@t, @t_nostalgia);

-- 21. Is It Over Now?
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Is It Over Now?'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_heartbreak), (@t, @t_anger), (@t, @t_humiliation);
