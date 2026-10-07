-- Theme/mood data: folklore.
-- No Taylor's Version (not yet re-recorded), so one recording per
-- song. Same caveat as every themes_*.sql file: my own reading of
-- each song, not externally verified.

INSERT INTO themes (name) VALUES
    ('rebellion'), ('legacy'), ('scandal'), ('adaptability'),
    ('innocence'), ('struggle'), ('shame'), ('fate'), ('trauma'),
    ('resignation'), ('tranquility')
ON DUPLICATE KEY UPDATE name = name;

SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_hindsight     := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_acceptance    := (SELECT theme_id FROM themes WHERE name = 'acceptance');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_devotion      := (SELECT theme_id FROM themes WHERE name = 'devotion');
SET @t_rebellion     := (SELECT theme_id FROM themes WHERE name = 'rebellion');
SET @t_legacy        := (SELECT theme_id FROM themes WHERE name = 'legacy');
SET @t_scandal       := (SELECT theme_id FROM themes WHERE name = 'scandal');
SET @t_miscommunication := (SELECT theme_id FROM themes WHERE name = 'miscommunication');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_resentment    := (SELECT theme_id FROM themes WHERE name = 'resentment');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_bitterness    := (SELECT theme_id FROM themes WHERE name = 'bitterness');
SET @t_insecurity    := (SELECT theme_id FROM themes WHERE name = 'insecurity');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_adaptability  := (SELECT theme_id FROM themes WHERE name = 'adaptability');
SET @t_childhood     := (SELECT theme_id FROM themes WHERE name = 'childhood');
SET @t_innocence     := (SELECT theme_id FROM themes WHERE name = 'innocence');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_bittersweet   := (SELECT theme_id FROM themes WHERE name = 'bittersweetness');
SET @t_struggle      := (SELECT theme_id FROM themes WHERE name = 'struggle');
SET @t_perseverance  := (SELECT theme_id FROM themes WHERE name = 'perseverance');
SET @t_secrecy       := (SELECT theme_id FROM themes WHERE name = 'secrecy');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_shame         := (SELECT theme_id FROM themes WHERE name = 'shame');
SET @t_fate          := (SELECT theme_id FROM themes WHERE name = 'fate');
SET @t_wonder        := (SELECT theme_id FROM themes WHERE name = 'wonder');
SET @t_anger         := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_injustice     := (SELECT theme_id FROM themes WHERE name = 'injustice');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_trauma        := (SELECT theme_id FROM themes WHERE name = 'trauma');
SET @t_compassion    := (SELECT theme_id FROM themes WHERE name = 'compassion');
SET @t_apology       := (SELECT theme_id FROM themes WHERE name = 'apology');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_young_love    := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_uncertainty   := (SELECT theme_id FROM themes WHERE name = 'uncertainty');
SET @t_resignation   := (SELECT theme_id FROM themes WHERE name = 'resignation');
SET @t_escape        := (SELECT theme_id FROM themes WHERE name = 'escape');
SET @t_tranquility   := (SELECT theme_id FROM themes WHERE name = 'tranquility');

-- 1. the 1
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'the 1'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_hindsight), (@r, @t_acceptance);

-- 2. cardigan
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'cardigan'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_romance), (@r, @t_devotion);

-- 3. the last great american dynasty
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'the last great american dynasty'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_rebellion), (@r, @t_legacy), (@r, @t_scandal);

-- 4. exile
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'exile'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_miscommunication), (@r, @t_heartbreak), (@r, @t_resentment);

-- 5. my tears ricochet
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'my tears ricochet'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_betrayal), (@r, @t_grief), (@r, @t_bitterness);

-- 6. mirrorball
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'mirrorball'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_insecurity), (@r, @t_vulnerability), (@r, @t_adaptability);

-- 7. seven
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'seven'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_childhood), (@r, @t_nostalgia), (@r, @t_innocence);

-- 8. august
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'august'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_longing), (@r, @t_nostalgia), (@r, @t_bittersweet);

-- 9. this is me trying
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'this is me trying'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_struggle), (@r, @t_insecurity), (@r, @t_perseverance);

-- 10. illicit affairs
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'illicit affairs'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_secrecy), (@r, @t_guilt), (@r, @t_shame);

-- 11. invisible string
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'invisible string'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fate), (@r, @t_romance), (@r, @t_wonder);

-- 12. mad woman
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'mad woman'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_anger), (@r, @t_injustice), (@r, @t_defiance);

-- 13. epiphany
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'epiphany'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_trauma), (@r, @t_compassion), (@r, @t_grief);

-- 14. betty
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'betty'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_apology), (@r, @t_regret), (@r, @t_young_love);

-- 15. peace
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'peace'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_uncertainty), (@r, @t_devotion), (@r, @t_insecurity);

-- 16. hoax
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'hoax'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_heartbreak), (@r, @t_devotion), (@r, @t_resignation);

-- 17. the lakes
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'the lakes'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_escape), (@r, @t_tranquility), (@r, @t_longing);
