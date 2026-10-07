-- Theme/mood data: evermore.
-- No Taylor's Version (not yet re-recorded), so one recording per
-- song. Same caveat as every themes_*.sql file: my own reading of
-- each song, not externally verified.

INSERT INTO themes (name) VALUES
    ('suspicion'), ('cynicism'), ('resolution'), ('stagnation'),
    ('letting go')
ON DUPLICATE KEY UPDATE name = name;

SET @t_fate          := (SELECT theme_id FROM themes WHERE name = 'fate');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_wonder        := (SELECT theme_id FROM themes WHERE name = 'wonder');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_struggle      := (SELECT theme_id FROM themes WHERE name = 'struggle');
SET @t_jealousy      := (SELECT theme_id FROM themes WHERE name = 'jealousy');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_anxiety       := (SELECT theme_id FROM themes WHERE name = 'anxiety');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_unrequited    := (SELECT theme_id FROM themes WHERE name = 'unrequited love');
SET @t_devotion      := (SELECT theme_id FROM themes WHERE name = 'devotion');
SET @t_loneliness    := (SELECT theme_id FROM themes WHERE name = 'loneliness');
SET @t_revenge       := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_suspicion     := (SELECT theme_id FROM themes WHERE name = 'suspicion');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_bitterness    := (SELECT theme_id FROM themes WHERE name = 'bitterness');
SET @t_acceptance    := (SELECT theme_id FROM themes WHERE name = 'acceptance');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_admiration    := (SELECT theme_id FROM themes WHERE name = 'admiration');
SET @t_miscommunication := (SELECT theme_id FROM themes WHERE name = 'miscommunication');
SET @t_forbidden     := (SELECT theme_id FROM themes WHERE name = 'forbidden love');
SET @t_passion       := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_cynicism      := (SELECT theme_id FROM themes WHERE name = 'cynicism');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_relief        := (SELECT theme_id FROM themes WHERE name = 'relief');
SET @t_legacy        := (SELECT theme_id FROM themes WHERE name = 'legacy');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_resentment    := (SELECT theme_id FROM themes WHERE name = 'resentment');
SET @t_resolution    := (SELECT theme_id FROM themes WHERE name = 'resolution');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_perseverance  := (SELECT theme_id FROM themes WHERE name = 'perseverance');
SET @t_stagnation    := (SELECT theme_id FROM themes WHERE name = 'stagnation');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_letting_go    := (SELECT theme_id FROM themes WHERE name = 'letting go');

-- 1. willow
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'willow'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fate), (@r, @t_romance), (@r, @t_wonder);

-- 2. champagne problems
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'champagne problems'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_heartbreak), (@r, @t_regret), (@r, @t_struggle);

-- 3. gold rush
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'gold rush'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_jealousy), (@r, @t_infatuation), (@r, @t_anxiety);

-- 4. 'tis the damn season
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "'tis the damn season"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_temptation), (@r, @t_longing);

-- 5. tolerate it
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'tolerate it'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_unrequited), (@r, @t_devotion), (@r, @t_loneliness);

-- 6. no body, no crime
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'no body, no crime'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_revenge), (@r, @t_suspicion), (@r, @t_betrayal);

-- 7. happiness
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'happiness'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_bitterness), (@r, @t_acceptance), (@r, @t_grief);

-- 8. dorothea
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'dorothea'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_admiration), (@r, @t_longing);

-- 9. coney island
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'coney island'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_regret), (@r, @t_heartbreak), (@r, @t_miscommunication);

-- 10. ivy
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'ivy'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_forbidden), (@r, @t_passion), (@r, @t_guilt);

-- 11. cowboy like me
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'cowboy like me'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_cynicism), (@r, @t_hope);

-- 12. long story short
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'long story short'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_gratitude), (@r, @t_relief), (@r, @t_hope);

-- 13. marjorie
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'marjorie'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_legacy), (@r, @t_nostalgia);

-- 14. closure
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'closure'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_defiance), (@r, @t_resentment), (@r, @t_resolution);

-- 15. evermore
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'evermore'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_healing), (@r, @t_hope), (@r, @t_perseverance);

-- 16. right where you left me
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'right where you left me'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_heartbreak), (@r, @t_grief), (@r, @t_stagnation);

-- 17. it's time to go
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "it's time to go"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_self_disc), (@r, @t_acceptance), (@r, @t_letting_go);
