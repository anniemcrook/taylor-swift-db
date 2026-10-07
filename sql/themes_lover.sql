-- Theme/mood data: Lover.
-- No Taylor's Version (not yet re-recorded), so one recording per
-- song. Same caveat as every themes_*.sql file: my own reading of
-- each song, not externally verified.

INSERT INTO themes (name) VALUES
    ('indifference'), ('injustice'), ('empowerment')
ON DUPLICATE KEY UPDATE name = name;

SET @t_moving_on     := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_indifference  := (SELECT theme_id FROM themes WHERE name = 'indifference');
SET @t_relief        := (SELECT theme_id FROM themes WHERE name = 'relief');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_anxiety       := (SELECT theme_id FROM themes WHERE name = 'anxiety');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_devotion      := (SELECT theme_id FROM themes WHERE name = 'devotion');
SET @t_commitment    := (SELECT theme_id FROM themes WHERE name = 'commitment');
SET @t_frustration   := (SELECT theme_id FROM themes WHERE name = 'frustration');
SET @t_injustice     := (SELECT theme_id FROM themes WHERE name = 'injustice');
SET @t_empowerment   := (SELECT theme_id FROM themes WHERE name = 'empowerment');
SET @t_insecurity    := (SELECT theme_id FROM themes WHERE name = 'insecurity');
SET @t_fear          := (SELECT theme_id FROM themes WHERE name = 'fear');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_playfulness   := (SELECT theme_id FROM themes WHERE name = 'playfulness');
SET @t_disillusion   := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_happiness     := (SELECT theme_id FROM themes WHERE name = 'happiness');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_loss          := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_joy           := (SELECT theme_id FROM themes WHERE name = 'joy');
SET @t_new_love      := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_passion       := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_uncertainty   := (SELECT theme_id FROM themes WHERE name = 'uncertainty');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_compassion    := (SELECT theme_id FROM themes WHERE name = 'compassion');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_apology       := (SELECT theme_id FROM themes WHERE name = 'apology');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_friendship    := (SELECT theme_id FROM themes WHERE name = 'friendship');

-- 1. I Forgot That You Existed
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Forgot That You Existed'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_moving_on), (@r, @t_indifference), (@r, @t_relief);

-- 2. Cruel Summer
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cruel Summer'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_infatuation), (@r, @t_anxiety), (@r, @t_desire);

-- 3. Lover
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Lover'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_devotion), (@r, @t_commitment);

-- 4. The Man
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Man'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_frustration), (@r, @t_injustice), (@r, @t_empowerment);

-- 5. The Archer
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Archer'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_insecurity), (@r, @t_fear), (@r, @t_vulnerability);

-- 6. I Think He Knows
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Think He Knows'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_desire), (@r, @t_confidence), (@r, @t_playfulness);

-- 7. Miss Americana & the Heartbreak Prince
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Miss Americana & the Heartbreak Prince'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_disillusion), (@r, @t_anxiety);

-- 8. Paper Rings
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Paper Rings'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_commitment), (@r, @t_playfulness), (@r, @t_happiness);

-- 9. Cornelia Street
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cornelia Street'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fear), (@r, @t_nostalgia), (@r, @t_romance);

-- 10. Death by a Thousand Cuts
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Death by a Thousand Cuts'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_heartbreak), (@r, @t_loss), (@r, @t_longing);

-- 11. London Boy
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'London Boy'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_infatuation), (@r, @t_joy), (@r, @t_new_love);

-- 12. Soon You'll Get Better
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "Soon You'll Get Better"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_fear), (@r, @t_hope);

-- 13. False God
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'False God'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_devotion), (@r, @t_passion), (@r, @t_uncertainty);

-- 14. You Need to Calm Down
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'You Need to Calm Down'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_defiance), (@r, @t_compassion), (@r, @t_frustration);

-- 15. Afterglow
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Afterglow'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_regret), (@r, @t_apology), (@r, @t_guilt);

-- 16. Me!
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Me!'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_self_disc), (@r, @t_confidence), (@r, @t_joy);

-- 17. It's Nice to Have a Friend
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "It's Nice to Have a Friend"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_friendship), (@r, @t_gratitude), (@r, @t_nostalgia);

-- 18. Daylight
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Daylight'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_healing), (@r, @t_gratitude), (@r, @t_hope);
