-- Theme/mood data: Midnights (3am + Till Dawn edition, one combined
-- album in this catalog). No Taylor's Version, so one recording per
-- song. The "Snow on the Beach" and "Karma" remixes aren't
-- separately tagged, same as other alternate mixes in this project.
-- Same caveat as every themes_*.sql file: my own reading of each
-- song, not externally verified.

INSERT INTO themes (name) VALUES
    ('disbelief'), ('independence'), ('ambition'), ('calculation'),
    ('surprise'), ('wisdom'), ('exhaustion')
ON DUPLICATE KEY UPDATE name = name;

SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_secrecy       := (SELECT theme_id FROM themes WHERE name = 'secrecy');
SET @t_passion       := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_bittersweet   := (SELECT theme_id FROM themes WHERE name = 'bittersweetness');
SET @t_insecurity    := (SELECT theme_id FROM themes WHERE name = 'insecurity');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_anxiety       := (SELECT theme_id FROM themes WHERE name = 'anxiety');
SET @t_wonder        := (SELECT theme_id FROM themes WHERE name = 'wonder');
SET @t_disbelief     := (SELECT theme_id FROM themes WHERE name = 'disbelief');
SET @t_growing_up    := (SELECT theme_id FROM themes WHERE name = 'growing up');
SET @t_independence  := (SELECT theme_id FROM themes WHERE name = 'independence');
SET @t_ambition      := (SELECT theme_id FROM themes WHERE name = 'ambition');
SET @t_moving_on     := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_uncertainty   := (SELECT theme_id FROM themes WHERE name = 'uncertainty');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_revenge       := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_empowerment   := (SELECT theme_id FROM themes WHERE name = 'empowerment');
SET @t_fear          := (SELECT theme_id FROM themes WHERE name = 'fear');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_triumph       := (SELECT theme_id FROM themes WHERE name = 'triumph');
SET @t_comfort       := (SELECT theme_id FROM themes WHERE name = 'comfort');
SET @t_tranquility   := (SELECT theme_id FROM themes WHERE name = 'tranquility');
SET @t_calculation   := (SELECT theme_id FROM themes WHERE name = 'calculation');
SET @t_perseverance  := (SELECT theme_id FROM themes WHERE name = 'perseverance');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_loss          := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_escape        := (SELECT theme_id FROM themes WHERE name = 'escape');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_surprise      := (SELECT theme_id FROM themes WHERE name = 'surprise');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_confusion     := (SELECT theme_id FROM themes WHERE name = 'confusion');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_anger         := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_hindsight     := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_wisdom        := (SELECT theme_id FROM themes WHERE name = 'wisdom');
SET @t_compassion    := (SELECT theme_id FROM themes WHERE name = 'compassion');
SET @t_desperation   := (SELECT theme_id FROM themes WHERE name = 'desperation');
SET @t_exhaustion    := (SELECT theme_id FROM themes WHERE name = 'exhaustion');

-- 1. Lavender Haze
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Lavender Haze'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_defiance), (@r, @t_secrecy);

-- 2. Maroon
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Maroon'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_passion), (@r, @t_nostalgia), (@r, @t_bittersweet);

-- 3. Anti-Hero
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Anti-Hero'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_insecurity), (@r, @t_self_disc), (@r, @t_anxiety);

-- 4. Snow on the Beach
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Snow on the Beach'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_wonder), (@r, @t_romance), (@r, @t_disbelief);

-- 5. You're on Your Own, Kid
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = "You're on Your Own, Kid"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_growing_up), (@r, @t_self_disc), (@r, @t_nostalgia);

-- 6. Midnight Rain
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Midnight Rain'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_independence), (@r, @t_ambition), (@r, @t_moving_on);

-- 7. Question...?
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Question...?'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_uncertainty), (@r, @t_longing), (@r, @t_anxiety);

-- 8. Vigilante Shit
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Vigilante Shit'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_revenge), (@r, @t_defiance), (@r, @t_confidence);

-- 9. Bejeweled
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bejeweled'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_confidence), (@r, @t_self_disc), (@r, @t_empowerment);

-- 10. Labyrinth
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Labyrinth'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fear), (@r, @t_hope), (@r, @t_vulnerability);

-- 11. Karma
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Karma'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_confidence), (@r, @t_revenge), (@r, @t_triumph);

-- 12. Sweet Nothing
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sweet Nothing'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_comfort), (@r, @t_romance), (@r, @t_tranquility);

-- 13. Mastermind
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Mastermind'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_calculation), (@r, @t_romance), (@r, @t_vulnerability);

-- 14. The Great War
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Great War'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_perseverance), (@r, @t_romance), (@r, @t_healing);

-- 15. Bigger Than the Whole Sky
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Bigger Than the Whole Sky'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_loss), (@r, @t_heartbreak);

-- 16. Paris
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Paris'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_escape), (@r, @t_wonder);

-- 17. High Infidelity
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'High Infidelity'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_guilt), (@r, @t_betrayal), (@r, @t_temptation);

-- 18. Glitch
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Glitch'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_surprise), (@r, @t_desire), (@r, @t_confusion);

-- 19. Would've, Could've, Should've
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = "Would've, Could've, Should've"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_regret), (@r, @t_anger), (@r, @t_hindsight);

-- 20. Dear Reader
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Dear Reader'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_vulnerability), (@r, @t_wisdom), (@r, @t_compassion);

-- 21. Hits Different
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Hits Different'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_heartbreak), (@r, @t_longing), (@r, @t_grief);

-- 22. You're Losing Me
SET @r := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = "You're Losing Me"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_desperation), (@r, @t_heartbreak), (@r, @t_exhaustion);
