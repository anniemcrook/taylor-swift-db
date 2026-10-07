-- Theme/mood data: The Tortured Poets Department (The Anthology
-- edition, all 31 tracks as one album entry in this catalog). No
-- Taylor's Version, so one recording per song. Same caveat as
-- every themes_*.sql file: my own reading of each song, not
-- externally verified.

INSERT INTO themes (name) VALUES
    ('numbness'), ('reinvention'), ('fantasy'), ('denial'),
    ('contempt'), ('detachment'), ('exposure'), ('curiosity'),
    ('avoidance'), ('tenderness')
ON DUPLICATE KEY UPDATE name = name;

SET @t_longing       := (SELECT theme_id FROM themes WHERE name = 'longing');
SET @t_obsession     := (SELECT theme_id FROM themes WHERE name = 'obsession');
SET @t_numbness      := (SELECT theme_id FROM themes WHERE name = 'numbness');
SET @t_disillusion   := (SELECT theme_id FROM themes WHERE name = 'disillusionment');
SET @t_irony         := (SELECT theme_id FROM themes WHERE name = 'irony');
SET @t_heartbreak    := (SELECT theme_id FROM themes WHERE name = 'heartbreak');
SET @t_frustration   := (SELECT theme_id FROM themes WHERE name = 'frustration');
SET @t_bitterness    := (SELECT theme_id FROM themes WHERE name = 'bitterness');
SET @t_grief         := (SELECT theme_id FROM themes WHERE name = 'grief');
SET @t_exhaustion    := (SELECT theme_id FROM themes WHERE name = 'exhaustion');
SET @t_resentment    := (SELECT theme_id FROM themes WHERE name = 'resentment');
SET @t_defiance      := (SELECT theme_id FROM themes WHERE name = 'defiance');
SET @t_romance       := (SELECT theme_id FROM themes WHERE name = 'romance');
SET @t_independence  := (SELECT theme_id FROM themes WHERE name = 'independence');
SET @t_relief        := (SELECT theme_id FROM themes WHERE name = 'relief');
SET @t_hope          := (SELECT theme_id FROM themes WHERE name = 'hope');
SET @t_new_love      := (SELECT theme_id FROM themes WHERE name = 'new love');
SET @t_escape        := (SELECT theme_id FROM themes WHERE name = 'escape');
SET @t_reinvention   := (SELECT theme_id FROM themes WHERE name = 'reinvention');
SET @t_desperation   := (SELECT theme_id FROM themes WHERE name = 'desperation');
SET @t_guilt         := (SELECT theme_id FROM themes WHERE name = 'guilt');
SET @t_desire        := (SELECT theme_id FROM themes WHERE name = 'desire');
SET @t_fantasy       := (SELECT theme_id FROM themes WHERE name = 'fantasy');
SET @t_betrayal      := (SELECT theme_id FROM themes WHERE name = 'betrayal');
SET @t_denial        := (SELECT theme_id FROM themes WHERE name = 'denial');
SET @t_confidence    := (SELECT theme_id FROM themes WHERE name = 'confidence');
SET @t_infatuation   := (SELECT theme_id FROM themes WHERE name = 'infatuation');
SET @t_facade        := (SELECT theme_id FROM themes WHERE name = 'facade');
SET @t_resilience    := (SELECT theme_id FROM themes WHERE name = 'resilience');
SET @t_contempt      := (SELECT theme_id FROM themes WHERE name = 'contempt');
SET @t_anger         := (SELECT theme_id FROM themes WHERE name = 'anger');
SET @t_triumph       := (SELECT theme_id FROM themes WHERE name = 'triumph');
SET @t_joy           := (SELECT theme_id FROM themes WHERE name = 'joy');
SET @t_fame          := (SELECT theme_id FROM themes WHERE name = 'fame');
SET @t_self_disc     := (SELECT theme_id FROM themes WHERE name = 'self-discovery');
SET @t_jealousy      := (SELECT theme_id FROM themes WHERE name = 'jealousy');
SET @t_playfulness   := (SELECT theme_id FROM themes WHERE name = 'playfulness');
SET @t_confusion     := (SELECT theme_id FROM themes WHERE name = 'confusion');
SET @t_self_awareness := (SELECT theme_id FROM themes WHERE name = 'self-awareness');
SET @t_fear          := (SELECT theme_id FROM themes WHERE name = 'fear');
SET @t_detachment    := (SELECT theme_id FROM themes WHERE name = 'detachment');
SET @t_moving_on     := (SELECT theme_id FROM themes WHERE name = 'moving on');
SET @t_exposure      := (SELECT theme_id FROM themes WHERE name = 'exposure');
SET @t_young_love    := (SELECT theme_id FROM themes WHERE name = 'young love');
SET @t_nostalgia     := (SELECT theme_id FROM themes WHERE name = 'nostalgia');
SET @t_bullying      := (SELECT theme_id FROM themes WHERE name = 'bullying');
SET @t_healing       := (SELECT theme_id FROM themes WHERE name = 'healing');
SET @t_loneliness    := (SELECT theme_id FROM themes WHERE name = 'loneliness');
SET @t_curiosity     := (SELECT theme_id FROM themes WHERE name = 'curiosity');
SET @t_injustice     := (SELECT theme_id FROM themes WHERE name = 'injustice');
SET @t_disappointment := (SELECT theme_id FROM themes WHERE name = 'disappointment');
SET @t_avoidance     := (SELECT theme_id FROM themes WHERE name = 'avoidance');
SET @t_tenderness    := (SELECT theme_id FROM themes WHERE name = 'tenderness');
SET @t_unconditional := (SELECT theme_id FROM themes WHERE name = 'unconditional love');
SET @t_hindsight     := (SELECT theme_id FROM themes WHERE name = 'hindsight');
SET @t_resolution    := (SELECT theme_id FROM themes WHERE name = 'resolution');

-- 1. Fortnight
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Fortnight'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_longing), (@r, @t_obsession), (@r, @t_numbness);

-- 2. The Tortured Poets Department
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Tortured Poets Department'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_disillusion), (@r, @t_irony), (@r, @t_heartbreak);

-- 3. My Boy Only Breaks His Favorite Toys
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'My Boy Only Breaks His Favorite Toys'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_frustration), (@r, @t_heartbreak), (@r, @t_bitterness);

-- 4. Down Bad
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Down Bad'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_heartbreak), (@r, @t_longing);

-- 5. So Long, London
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'So Long, London'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_exhaustion), (@r, @t_grief), (@r, @t_resentment);

-- 6. But Daddy I Love Him
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'But Daddy I Love Him'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_defiance), (@r, @t_romance), (@r, @t_independence);

-- 7. Fresh Out the Slammer
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Fresh Out the Slammer'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_relief), (@r, @t_hope), (@r, @t_new_love);

-- 8. Florida!!!
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Florida!!!'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_escape), (@r, @t_reinvention), (@r, @t_desperation);

-- 9. Guilty as Sin?
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Guilty as Sin?'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_guilt), (@r, @t_desire), (@r, @t_fantasy);

-- 10. Who's Afraid of Little Old Me?
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "Who's Afraid of Little Old Me?"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_bitterness), (@r, @t_defiance), (@r, @t_betrayal);

-- 11. I Can Fix Him (No Really I Can)
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Can Fix Him (No Really I Can)'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_denial), (@r, @t_confidence), (@r, @t_infatuation);

-- 12. loml
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'loml'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_heartbreak), (@r, @t_betrayal);

-- 13. I Can Do It With a Broken Heart
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Can Do It With a Broken Heart'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_facade), (@r, @t_resilience), (@r, @t_heartbreak);

-- 14. The Smallest Man Who Ever Lived
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Smallest Man Who Ever Lived'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_contempt), (@r, @t_betrayal), (@r, @t_anger);

-- 15. The Alchemy
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Alchemy'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_romance), (@r, @t_triumph), (@r, @t_joy);

-- 16. Clara Bow
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Clara Bow'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_fame), (@r, @t_self_disc), (@r, @t_disillusion);

-- 17. The Black Dog
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Black Dog'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_jealousy), (@r, @t_grief), (@r, @t_heartbreak);

-- 18. imgonnagetyouback
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'imgonnagetyouback'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_playfulness), (@r, @t_confusion), (@r, @t_desire);

-- 19. The Albatross
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Albatross'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_self_awareness), (@r, @t_romance), (@r, @t_fear);

-- 20. Chloe or Sam or Sophia or Marcus
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Chloe or Sam or Sophia or Marcus'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_numbness), (@r, @t_moving_on), (@r, @t_detachment);

-- 21. How Did It End?
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'How Did It End?'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_grief), (@r, @t_exposure), (@r, @t_heartbreak);

-- 22. So High School
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'So High School'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_young_love), (@r, @t_joy), (@r, @t_nostalgia);

-- 23. I Hate It Here
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'I Hate It Here'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_disillusion), (@r, @t_escape), (@r, @t_nostalgia);

-- 24. thanK you aIMee
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'thanK you aIMee'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_resentment), (@r, @t_bullying), (@r, @t_healing);

-- 25. I Look in People's Windows
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = "I Look in People's Windows"));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_loneliness), (@r, @t_longing), (@r, @t_curiosity);

-- 26. The Prophecy
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Prophecy'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_desperation), (@r, @t_loneliness), (@r, @t_hope);

-- 27. Cassandra
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Cassandra'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_loneliness), (@r, @t_injustice), (@r, @t_defiance);

-- 28. Peter
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Peter'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_nostalgia), (@r, @t_disappointment), (@r, @t_longing);

-- 29. The Bolter
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Bolter'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_avoidance), (@r, @t_independence), (@r, @t_fear);

-- 30. Robin
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'Robin'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_tenderness), (@r, @t_hope), (@r, @t_unconditional);

-- 31. The Manuscript
SET @r := (SELECT recording_id FROM recordings WHERE song_id = (SELECT song_id FROM songs WHERE title = 'The Manuscript'));
INSERT INTO recording_themes (recording_id, theme_id) VALUES (@r, @t_healing), (@r, @t_hindsight), (@r, @t_resolution);
