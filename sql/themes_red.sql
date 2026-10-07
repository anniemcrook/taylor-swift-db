-- Theme/mood data: Red + Red (Taylor's Version).
-- Same caveat as every themes_*.sql file: my own reading of each
-- song, not externally verified.
--
-- 19 songs shared between both versions get the same tags on both
-- the original and Taylor's Version recording. The 9 vault tracks
-- only exist on the TV edition. The acoustic/demo bonus recordings
-- (State of Grace acoustic, Treacherous demo, Red demo) aren't
-- separately tagged, same as other alternate takes in this project
-- — Moods matches by song, not recording.
--
-- Exception: All Too Well (10 Minute Version) (version_type
-- 'other') IS tagged separately from the standard-length original
-- and Taylor's Version recordings. This is the exact case the
-- per-recording design was meant for (see sql/0003_add_themes.sql
-- notes) — the extended cut adds whole verses of specific detail
-- (the scarf, the "paper rings" dig, the fight in the car) that the
-- 4-minute version doesn't have room for.

INSERT INTO themes (name) VALUES
    ('passion'), ('chaos'), ('danger'), ('carefree'), ('playfulness'),
    ('happiness'), ('acceptance'), ('fame'), ('healing'), ('disappointment'),
    ('integrity'), ('self-respect'), ('grief'), ('unconditional love'),
    ('confidence'), ('spite'), ('sadness'), ('urgency'), ('escape'),
    ('joy'), ('catharsis')
ON DUPLICATE KEY UPDATE name = name;

SET @t_new_love      := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_uncertainty   := (SELECT theme_id FROM themes WHERE name = 'uncertainty');
SET @t_passion       := (SELECT theme_id FROM themes WHERE name = 'passion');
SET @t_chaos         := (SELECT theme_id FROM themes WHERE name = 'chaos');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_danger        := (SELECT theme_id FROM themes WHERE name = 'danger');
SET @t_forbidden     := (SELECT theme_id FROM themes WHERE name = 'forbidden love');
SET @t_regret        := (SELECT theme_id FROM themes WHERE name = 'regret');
SET @t_hindsight     := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_loss          := (SELECT theme_id FROM themes WHERE name = 'loss');
SET @t_friendship    := (SELECT theme_id FROM themes WHERE name = 'friendship');
SET @t_carefree      := (SELECT theme_id FROM themes WHERE name = 'carefree');
SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_temptation    := (SELECT theme_id FROM themes WHERE name = 'temptation');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_breakup       := (SELECT theme_id FROM themes WHERE name = 'breakup');
SET @t_moving_on     := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_playfulness   := (SELECT theme_id FROM themes WHERE name = 'playfulness');
SET @t_happiness     := (SELECT theme_id FROM themes WHERE name = 'happiness');
SET @t_desperation   := (SELECT theme_id FROM themes WHERE name = 'desperation');
SET @t_gratitude     := (SELECT theme_id FROM themes WHERE name = 'gratitude');
SET @t_bittersweet   := (SELECT theme_id FROM themes WHERE name = 'bittersweetness');
SET @t_acceptance    := (SELECT theme_id FROM themes WHERE name = 'acceptance');
SET @t_loneliness    := (SELECT theme_id FROM themes WHERE name = 'loneliness');
SET @t_fame          := (SELECT theme_id FROM themes WHERE name = 'fame');
SET @t_disillusion   := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_wonder        := (SELECT theme_id FROM themes WHERE name = 'wonder');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_disappointment := (SELECT theme_id FROM themes WHERE name = 'disappointment');
SET @t_fear          := (SELECT theme_id FROM themes WHERE name = 'fear');
SET @t_waiting       := (SELECT theme_id FROM themes WHERE name = 'waiting');
SET @t_integrity     := (SELECT theme_id FROM themes WHERE name = 'integrity');
SET @t_self_respect  := (SELECT theme_id FROM themes WHERE name = 'self-respect');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_unconditional := (SELECT theme_id FROM themes WHERE name = 'unconditional love');
SET @t_insecurity    := (SELECT theme_id FROM themes WHERE name = 'insecurity');
SET @t_vulnerability := (SELECT theme_id FROM themes WHERE name = 'vulnerability');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_anger         := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_crush         := (SELECT theme_id FROM themes WHERE name = 'crush');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_spite         := (SELECT theme_id FROM themes WHERE name = 'spite');
SET @t_concern       := (SELECT theme_id FROM themes WHERE name = 'concern');
SET @t_sadness       := (SELECT theme_id FROM themes WHERE name = 'sadness');
SET @t_urgency       := (SELECT theme_id FROM themes WHERE name = 'urgency');
SET @t_escape        := (SELECT theme_id FROM themes WHERE name = 'escape');
SET @t_joy           := (SELECT theme_id FROM themes WHERE name = 'joy');
SET @t_young_love    := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_catharsis     := (SELECT theme_id FROM themes WHERE name = 'catharsis');

-- 1. State of Grace
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'State of Grace'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'State of Grace'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_new_love), (@o, @t_hope), (@o, @t_uncertainty),
    (@t, @t_new_love), (@t, @t_hope), (@t, @t_uncertainty);

-- 2. Red
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Red'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Red'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_passion), (@o, @t_chaos), (@o, @t_heartbreak),
    (@t, @t_passion), (@t, @t_chaos), (@t, @t_heartbreak);

-- 3. Treacherous
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Treacherous'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Treacherous'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_desire), (@o, @t_danger), (@o, @t_forbidden),
    (@t, @t_desire), (@t, @t_danger), (@t, @t_forbidden);

-- 4. I Knew You Were Trouble
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Knew You Were Trouble'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Knew You Were Trouble'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_regret), (@o, @t_heartbreak), (@o, @t_hindsight),
    (@t, @t_regret), (@t, @t_heartbreak), (@t, @t_hindsight);

-- 5. All Too Well (standard length)
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'All Too Well'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'All Too Well'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_heartbreak), (@o, @t_nostalgia), (@o, @t_loss),
    (@t, @t_heartbreak), (@t, @t_nostalgia), (@t, @t_loss);

-- 5b. All Too Well (10 Minute Version) — tagged separately; see
-- header note. Same core themes plus the sharper, more specific
-- ones the extra verses bring out.
SET @r10 := (SELECT recording_id FROM recordings WHERE version_type = 'other' AND song_id = (SELECT song_id FROM songs WHERE title = 'All Too Well'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@r10, @t_heartbreak), (@r10, @t_nostalgia), (@r10, @t_loss),
    (@r10, @t_betrayal), (@r10, @t_catharsis), (@r10, @t_anger);

-- 6. 22
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = '22'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = '22'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_friendship), (@o, @t_hope), (@o, @t_carefree),
    (@t, @t_friendship), (@t, @t_hope), (@t, @t_carefree);

-- 7. I Almost Do
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Almost Do'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Almost Do'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_temptation), (@o, @t_regret),
    (@t, @t_longing), (@t, @t_temptation), (@t, @t_regret);

-- 8. We Are Never Ever Getting Back Together
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'We Are Never Ever Getting Back Together'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'We Are Never Ever Getting Back Together'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_defiance), (@o, @t_breakup), (@o, @t_moving_on),
    (@t, @t_defiance), (@t, @t_breakup), (@t, @t_moving_on);

-- 9. Stay Stay Stay
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Stay Stay Stay'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Stay Stay Stay'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_playfulness), (@o, @t_happiness),
    (@t, @t_romance), (@t, @t_playfulness), (@t, @t_happiness);

-- 10. The Last Time
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Last Time'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Last Time'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_desperation), (@o, @t_heartbreak), (@o, @t_hope),
    (@t, @t_desperation), (@t, @t_heartbreak), (@t, @t_hope);

-- 11. Holy Ground
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Holy Ground'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Holy Ground'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_nostalgia), (@o, @t_gratitude), (@o, @t_bittersweet),
    (@t, @t_nostalgia), (@t, @t_gratitude), (@t, @t_bittersweet);

-- 12. Sad Beautiful Tragic
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sad Beautiful Tragic'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Sad Beautiful Tragic'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_heartbreak), (@o, @t_loss), (@o, @t_acceptance),
    (@t, @t_heartbreak), (@t, @t_loss), (@t, @t_acceptance);

-- 13. The Lucky One
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Lucky One'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Lucky One'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_loneliness), (@o, @t_fame), (@o, @t_disillusion),
    (@t, @t_loneliness), (@t, @t_fame), (@t, @t_disillusion);

-- 14. Everything Has Changed
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Everything Has Changed'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Everything Has Changed'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_new_love), (@o, @t_wonder), (@o, @t_hope),
    (@t, @t_new_love), (@t, @t_wonder), (@t, @t_hope);

-- 15. Starlight
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Starlight'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Starlight'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_romance), (@o, @t_nostalgia), (@o, @t_wonder),
    (@t, @t_romance), (@t, @t_nostalgia), (@t, @t_wonder);

-- 16. Begin Again
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Begin Again'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Begin Again'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_hope), (@o, @t_healing), (@o, @t_new_love),
    (@t, @t_hope), (@t, @t_healing), (@t, @t_new_love);

-- 17. The Moment I Knew
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Moment I Knew'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Moment I Knew'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_heartbreak), (@o, @t_disappointment), (@o, @t_loneliness),
    (@t, @t_heartbreak), (@t, @t_disappointment), (@t, @t_loneliness);

-- 18. Come Back... Be Here
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Come Back... Be Here'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Come Back... Be Here'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_longing), (@o, @t_fear), (@o, @t_waiting),
    (@t, @t_longing), (@t, @t_fear), (@t, @t_waiting);

-- 19. Girl at Home
SET @o := (SELECT recording_id FROM recordings WHERE version_type = 'original' AND song_id = (SELECT song_id FROM songs WHERE title = 'Girl at Home'));
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Girl at Home'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@o, @t_temptation), (@o, @t_integrity), (@o, @t_self_respect),
    (@t, @t_temptation), (@t, @t_integrity), (@t, @t_self_respect);

-- 20-28: From the Vault, exclusive to the TV edition.

-- 20. Ronan
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Ronan'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_grief), (@t, @t_loss), (@t, @t_unconditional);

-- 21. Better Man
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Better Man'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_heartbreak), (@t, @t_regret), (@t, @t_longing);

-- 22. Nothing New
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Nothing New'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_insecurity), (@t, @t_fear), (@t, @t_vulnerability);

-- 23. Babe
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Babe'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_betrayal), (@t, @t_heartbreak), (@t, @t_anger);

-- 24. Message in a Bottle
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Message in a Bottle'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_crush), (@t, @t_hope), (@t, @t_longing);

-- 25. I Bet You Think About Me
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'I Bet You Think About Me'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_confidence), (@t, @t_nostalgia), (@t, @t_spite);

-- 26. Forever Winter
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Forever Winter'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_concern), (@t, @t_desperation), (@t, @t_sadness);

-- 27. Run
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'Run'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_urgency), (@t, @t_romance), (@t, @t_escape);

-- 28. The Very First Night
SET @t := (SELECT recording_id FROM recordings WHERE version_type = 'taylors_version' AND song_id = (SELECT song_id FROM songs WHERE title = 'The Very First Night'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES
    (@t, @t_nostalgia), (@t, @t_joy), (@t, @t_young_love);
