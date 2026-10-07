-- Theme/mood data: Taylor Swift (2006 debut). No Taylor's Version,
-- so one recording per song. Same caveat as every themes_*.sql file:
-- my own reading of each song, not externally verified.

INSERT INTO themes (name) VALUES
    ('revenge'), ('self-discovery'), ('uncertainty'), ('loneliness'),
    ('belonging'), ('concern'), ('growing old together')
ON DUPLICATE KEY UPDATE name = name;

SET @t_nostalgia    := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_young_love   := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_longing      := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_anger        := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_breakup      := (SELECT theme_id FROM themes WHERE name = 'breakup');
SET @t_revenge      := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_unrequited   := (SELECT theme_id FROM themes WHERE name = 'unrequited love');
SET @t_heartbreak   := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_self_disc    := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_uncertainty  := (SELECT theme_id FROM themes WHERE name = 'uncertainty');
SET @t_hope         := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_betrayal     := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_disillusion  := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_loneliness   := (SELECT theme_id FROM themes WHERE name = 'loneliness');
SET @t_belonging    := (SELECT theme_id FROM themes WHERE name = 'belonging');
SET @t_concern      := (SELECT theme_id FROM themes WHERE name = 'concern');
SET @t_facade       := (SELECT theme_id FROM themes WHERE name = 'facade');
SET @t_friendship   := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_admiration   := (SELECT theme_id FROM themes WHERE name = 'admiration');
SET @t_crush        := (SELECT theme_id FROM themes WHERE name = 'crush');
SET @t_regret       := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_growing_old  := (SELECT theme_id FROM themes WHERE name = 'growing old together');
SET @t_romance      := (SELECT theme_id FROM themes WHERE name = 'romance');

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Tim McGraw'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_young_love), (@r, @t_longing);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Picture to Burn'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_anger), (@r, @t_breakup), (@r, @t_revenge);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Teardrops on My Guitar'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_unrequited), (@r, @t_longing), (@r, @t_heartbreak);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'A Place in This World'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_self_disc), (@r, @t_uncertainty), (@r, @t_hope);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cold as You'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_betrayal), (@r, @t_heartbreak), (@r, @t_disillusion);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Outside'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_loneliness), (@r, @t_longing), (@r, @t_belonging);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Tied Together with a Smile'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_concern), (@r, @t_facade), (@r, @t_friendship);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Stay Beautiful'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_admiration), (@r, @t_crush), (@r, @t_hope);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "Should've Said No"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_betrayal), (@r, @t_regret), (@r, @t_anger);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "Mary's Song (Oh My My My)"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_young_love), (@r, @t_growing_old);

SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Our Song'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_young_love), (@r, @t_nostalgia), (@r, @t_romance);
