-- Theme/mood data: The Life of a Showgirl.
-- No Taylor's Version (brand new album), so one recording per song.
-- Same caveat as every themes_*.sql file: my own reading of each
-- song, not externally verified — and given how recent this release
-- is, treat these tags as an even earlier first draft than usual.

INSERT INTO themes (name) VALUES
    ('rescue'), ('responsibility'), ('pressure'), ('amusement'),
    ('contentment'), ('loyalty'), ('flirtation'), ('euphoria'),
    ('excess')
ON DUPLICATE KEY UPDATE name = name;

SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_rescue        := (SELECT theme_id FROM themes WHERE name = 'rescue');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_fame          := (SELECT theme_id FROM themes WHERE name = 'fame');
SET @t_resilience    := (SELECT theme_id FROM themes WHERE name = 'resilience');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_manipulation  := (SELECT theme_id FROM themes WHERE name = 'manipulation');
SET @t_disillusion   := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_responsibility := (SELECT theme_id FROM themes WHERE name = 'responsibility');
SET @t_pressure      := (SELECT theme_id FROM themes WHERE name = 'pressure');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_loss          := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_irony         := (SELECT theme_id FROM themes WHERE name = 'irony');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_amusement     := (SELECT theme_id FROM themes WHERE name = 'amusement');
SET @t_contentment   := (SELECT theme_id FROM themes WHERE name = 'contentment');
SET @t_playfulness   := (SELECT theme_id FROM themes WHERE name = 'playfulness');
SET @t_joy           := (SELECT theme_id FROM themes WHERE name = 'joy');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_loyalty       := (SELECT theme_id FROM themes WHERE name = 'loyalty');
SET @t_friendship    := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_tenderness    := (SELECT theme_id FROM themes WHERE name = 'tenderness');
SET @t_new_love      := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_trust         := (SELECT theme_id FROM themes WHERE name = 'trust');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_obsession     := (SELECT theme_id FROM themes WHERE name = 'obsession');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_danger        := (SELECT theme_id FROM themes WHERE name = 'danger');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_flirtation    := (SELECT theme_id FROM themes WHERE name = 'flirtation');
SET @t_denial        := (SELECT theme_id FROM themes WHERE name = 'denial');
SET @t_euphoria      := (SELECT theme_id FROM themes WHERE name = 'euphoria');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_excess        := (SELECT theme_id FROM themes WHERE name = 'excess');

-- 1. The Fate of Ophelia
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Fate of Ophelia'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_rescue), (@r, @t_gratitude);

-- 2. Elizabeth Taylor
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Elizabeth Taylor'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fame), (@r, @t_romance), (@r, @t_resilience);

-- 3. Opalite
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Opalite'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_hope), (@r, @t_romance), (@r, @t_healing);

-- 4. Father Figure
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Father Figure'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_betrayal), (@r, @t_manipulation), (@r, @t_disillusion);

-- 5. Eldest Daughter
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Eldest Daughter'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_responsibility), (@r, @t_pressure), (@r, @t_self_disc);

-- 6. Ruin the Friendship
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Ruin the Friendship'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_regret), (@r, @t_longing), (@r, @t_loss);

-- 7. Actually Romantic
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Actually Romantic'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_irony), (@r, @t_confidence), (@r, @t_amusement);

-- 8. Wi$h Li$t
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Wi$h Li$t'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_contentment), (@r, @t_romance), (@r, @t_gratitude);

-- 9. Wood
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Wood'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_playfulness), (@r, @t_romance), (@r, @t_joy);

-- 10. Cancelled!
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cancelled!'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_defiance), (@r, @t_loyalty), (@r, @t_friendship);

-- 11. Honey
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Honey'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_tenderness), (@r, @t_new_love), (@r, @t_trust);

-- 12. The Life of a Showgirl
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Life of a Showgirl'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fame), (@r, @t_vulnerability), (@r, @t_resilience);

-- 13. Patient Zero
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Patient Zero'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_obsession), (@r, @t_infatuation), (@r, @t_danger);

-- 14. Cleveland!
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cleveland!'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_playfulness), (@r, @t_desire), (@r, @t_flirtation);

-- 15. Pink Clouding
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Pink Clouding'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_infatuation), (@r, @t_denial), (@r, @t_euphoria);

-- 16. Babylon
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Babylon'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_temptation), (@r, @t_fame), (@r, @t_excess);
