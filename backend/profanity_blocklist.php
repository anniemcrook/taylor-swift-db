<?php
// Flat list of disallowed words for user-submitted theme names. Not
// exhaustive, and deliberately not trying to be — this is a low-
// traffic personal project, not a platform that needs an
// industrial-strength filter. Checked as whole tokens, never as a
// substring, so this never flags something like "grape" or "classic"
// just because a blocked word happens to appear inside it (the
// "Scunthorpe problem"). See theme_name_contains_blocked_word() in
// helpers.php for how this is used.
return [
    'fuck', 'fucking', 'fucker', 'motherfucker',
    'shit', 'bullshit',
    'bitch', 'bastard', 'cunt', 'dick', 'pussy', 'cock',
    'whore', 'slut',
    'rape', 'raping', 'rapist', 'molest', 'molester', 'incest', 'pedophile', 'paedophile',
    'nigger', 'nigga', 'chink', 'spic', 'gook', 'kike', 'wetback', 'beaner',
    'fag', 'faggot', 'dyke', 'tranny',
    'retard', 'retarded',
];
