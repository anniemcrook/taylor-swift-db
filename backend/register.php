<?php
require __DIR__ . '/config.php';
require __DIR__ . '/auth.php';

if (current_user()) {
    header('Location: index.php');
    exit;
}

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$errors = [];
$email = '';
$displayName = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verify_csrf_token($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired — please try again.';
    }

    $email = trim((string) ($_POST['email'] ?? ''));
    $displayName = trim((string) ($_POST['display_name'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $passwordConfirm = (string) ($_POST['password_confirm'] ?? '');

    // Length checks matter here, not just format: `users.email` and
    // `users.display_name` are varchar(255)/varchar(100), and this
    // database runs in strict SQL mode, so an overlong value doesn't
    // get silently truncated — it throws. Reject it here with a
    // friendly message instead of letting that exception surface.
    // The password cap is for a different reason: bcrypt (what
    // password_hash() uses by default) silently truncates anything
    // past 72 bytes, so two different long passwords sharing the
    // same first 72 bytes would hash identically — reject rather
    // than rely on that silently.
    if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Enter a valid email address.';
    } elseif (strlen($email) > 255) {
        $errors[] = 'Email address is too long.';
    }
    if ($displayName === '') {
        $errors[] = 'Enter a display name.';
    } elseif (strlen($displayName) > 100) {
        $errors[] = 'Display name must be 100 characters or fewer.';
    }
    if (strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    } elseif (strlen($password) > 72) {
        $errors[] = 'Password must be 72 characters or fewer.';
    }
    if ($password !== $passwordConfirm) {
        $errors[] = 'Passwords do not match.';
    }

    if ($errors === []) {
        $existsStmt = $pdo->prepare('SELECT user_id FROM users WHERE email = :email');
        $existsStmt->execute(['email' => $email]);
        if ($existsStmt->fetch()) {
            $errors[] = 'An account with that email already exists — try logging in instead.';
        }
    }

    if ($errors === []) {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $insertStmt = $pdo->prepare('INSERT INTO users (email, password_hash, display_name) VALUES (:email, :hash, :name)');
        try {
            $insertStmt->execute(['email' => $email, 'hash' => $hash, 'name' => $displayName]);
            log_in_user((int) $pdo->lastInsertId(), $email, $displayName);
            header('Location: index.php');
            exit;
        } catch (PDOException $e) {
            // SQLSTATE 23000 = integrity constraint violation. Covers
            // the narrow race where two requests check "does this
            // email exist" at the same moment, both see no, and both
            // try to insert — the UNIQUE constraint on email lets only
            // one through, and the other lands here instead of the
            // pre-check above.
            if ($e->getCode() === '23000') {
                $errors[] = 'An account with that email already exists — try logging in instead.';
            } else {
                throw $e;
            }
        }
    }
}

$pageTitle = 'Register — Taylor Swift Catalogue';
$currentNav = null;
?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php include __DIR__ . '/head.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/nav.php'; ?>
    <main id="main">
        <h1>Register</h1>

        <?php if ($errors !== []): ?>
        <div class="form-errors">
            <ul>
                <?php foreach ($errors as $error): ?>
                <li><?= htmlspecialchars($error) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php endif; ?>

        <form method="post" action="register.php" class="auth-form">
            <?= csrf_field() ?>
            <label for="email">Email
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($email) ?>" required>
            </label>
            <label for="display_name">Display name
                <input type="text" id="display_name" name="display_name" value="<?= htmlspecialchars($displayName) ?>" required>
            </label>
            <label for="password">Password
                <input type="password" id="password" name="password" required minlength="8">
            </label>
            <label for="password_confirm">Confirm password
                <input type="password" id="password_confirm" name="password_confirm" required minlength="8">
            </label>
            <button type="submit">Create account</button>
        </form>

        <p class="muted">Already have an account? <a href="login.php">Log in</a>.</p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
