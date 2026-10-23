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

    if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Enter a valid email address.';
    }
    if ($displayName === '') {
        $errors[] = 'Enter a display name.';
    }
    if (strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
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
        $insertStmt->execute(['email' => $email, 'hash' => $hash, 'name' => $displayName]);
        log_in_user((int) $pdo->lastInsertId(), $email, $displayName);
        header('Location: index.php');
        exit;
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
