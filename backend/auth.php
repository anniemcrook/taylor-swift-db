<?php
// Shared authentication helpers. Starts the session, so this file
// must be required at the very top of every page — before any HTML
// is echoed — since PHP sessions need to set a cookie via a header,
// which has to happen before any other output.

if (session_status() === PHP_SESSION_NONE) {
    session_start([
        'cookie_httponly' => true,
        'cookie_samesite' => 'Lax',
    ]);
}

// Returns the logged-in user's id/email/display_name from the
// session, or null if nobody's logged in. Deliberately doesn't
// query the database — login already put everything needed into
// the session, so every page can check login state for free.
function current_user(): ?array
{
    if (!isset($_SESSION['user_id'])) {
        return null;
    }
    return [
        'user_id' => $_SESSION['user_id'],
        'email' => $_SESSION['user_email'],
        'display_name' => $_SESSION['user_display_name'],
    ];
}

function log_in_user(int $userId, string $email, string $displayName): void
{
    // Regenerating the session ID on login (a privilege change)
    // prevents session fixation — an attacker who somehow got a
    // visitor to use a known session ID before login can't reuse
    // that same ID to inherit the now-logged-in session.
    session_regenerate_id(true);
    $_SESSION['user_id'] = $userId;
    $_SESSION['user_email'] = $email;
    $_SESSION['user_display_name'] = $displayName;
}

function log_out_user(): void
{
    $_SESSION = [];
    if (ini_get('session.use_cookies')) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
    }
    session_destroy();
}

// --- CSRF protection, for any form that changes state (register,
// login, and anything logged-in users submit later — theme votes,
// tournament submissions, etc.) ---

function csrf_token(): string
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_field(): string
{
    return '<input type="hidden" name="csrf_token" value="' . htmlspecialchars(csrf_token(), ENT_QUOTES) . '">';
}

function verify_csrf_token(?string $token): bool
{
    return is_string($token) && isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
}
