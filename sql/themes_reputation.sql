-- Theme/mood data: reputation.
-- No Taylor's Version (not yet re-recorded), so one recording per
-- song. Same caveat as every themes_*.sql file: my own reading of
-- each song, not externally verified.

INSERT INTO themes (name) VALUES
    ('transformation'), ('guilt'), ('devotion')
ON DUPLICATE KEY UPDATE name = name;

SET @t_anticipation  := (SELECT theme_id FROM themes WHERE name = 'anticipation');
SET @t_excitement    := (SELECT theme_id FROM themes WHERE name = 'excitement');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_commitment    := (SELECT theme_id FROM themes WHERE name = 'commitment');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_revenge       := (SELECT theme_id FROM themes WHERE name = 'revenge');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_obsession     := (SELECT theme_id FROM themes WHERE name = 'obsession');
SET @t_passion       := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_new_love      := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_transformation := (SELECT theme_id FROM themes WHERE name = 'transformation');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_frustration   := (SELECT theme_id FROM themes WHERE name = 'frustration');
SET @t_escape        := (SELECT theme_id FROM themes WHERE name = 'escape');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_joy           := (SELECT theme_id FROM themes WHERE name = 'joy');
SET @t_comfort       := (SELECT theme_id FROM themes WHERE name = 'comfort');
SET @t_secrecy       := (SELECT theme_id FROM themes WHERE name = 'secrecy');
SET @t_concern       := (SELECT theme_id FROM themes WHERE name = 'concern');
SET @t_resentment    := (SELECT theme_id FROM themes WHERE name = 'resentment');
SET @t_bitterness    := (SELECT theme_id FROM themes WHERE name = 'bitterness');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_devotion      := (SELECT theme_id FROM themes WHERE name = 'devotion');

-- 1. ...Ready for It?
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = '...Ready for It?'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_anticipation), (@r, @t_excitement), (@r, @t_confidence);

-- 2. End Game
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'End Game'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_commitment), (@r, @t_vulnerability);

-- 3. I Did Something Bad
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Did Something Bad'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_revenge), (@r, @t_defiance), (@r, @t_confidence);

-- 4. Don't Blame Me
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "Don't Blame Me"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_obsession), (@r, @t_passion), (@r, @t_infatuation);

-- 5. Delicate
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Delicate'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_new_love), (@r, @t_vulnerability), (@r, @t_hope);

-- 6. Look What You Made Me Do
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Look What You Made Me Do'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_revenge), (@r, @t_betrayal), (@r, @t_transformation);

-- 7. So It Goes...
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'So It Goes...'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_desire), (@r, @t_passion), (@r, @t_temptation);

-- 8. Gorgeous
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Gorgeous'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_infatuation), (@r, @t_desire), (@r, @t_frustration);

-- 9. Getaway Car
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Getaway Car'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_escape), (@r, @t_guilt), (@r, @t_regret);

-- 10. King of My Heart
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'King of My Heart'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_joy), (@r, @t_comfort);

-- 11. Dancing with Our Hands Tied
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Dancing with Our Hands Tied'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_secrecy), (@r, @t_romance), (@r, @t_concern);

-- 12. Dress
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Dress'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_desire), (@r, @t_passion), (@r, @t_romance);

-- 13. This Is Why We Can't Have Nice Things
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "This Is Why We Can't Have Nice Things"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_resentment), (@r, @t_betrayal), (@r, @t_bitterness);

-- 14. Call It What You Want
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Call It What You Want'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_gratitude), (@r, @t_healing);

-- 15. New Year's Day
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "New Year's Day"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_devotion), (@r, @t_comfort);
