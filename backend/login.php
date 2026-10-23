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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!verify_csrf_token($_POST['csrf_token'] ?? null)) {
        $errors[] = 'Your session expired — please try again.';
    }

    $email = trim((string) ($_POST['email'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');

    if ($errors === []) {
        $stmt = $pdo->prepare('SELECT user_id, email, password_hash, display_name FROM users WHERE email = :email');
        $stmt->execute(['email' => $email]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row && password_verify($password, $row['password_hash'])) {
            log_in_user((int) $row['user_id'], $row['email'], $row['display_name']);
            header('Location: index.php');
            exit;
        }

        // Deliberately generic — same message whether the email
        // doesn't exist or the password was wrong, so a visitor
        // can't use this form to find out which emails are registered.
        $errors[] = 'Incorrect email or password.';
    }
}

$pageTitle = 'Log in — Taylor Swift Catalogue';
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
        <h1>Log in</h1>

        <?php if ($errors !== []): ?>
        <div class="form-errors">
            <ul>
                <?php foreach ($errors as $error): ?>
                <li><?= htmlspecialchars($error) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php endif; ?>

        <form method="post" action="login.php" class="auth-form">
            <?= csrf_field() ?>
            <label for="email">Email
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($email) ?>" required>
            </label>
            <label for="password">Password
                <input type="password" id="password" name="password" required>
            </label>
            <button type="submit">Log in</button>
        </form>

        <p class="muted">Don't have an account? <a href="register.php">Register</a>.</p>
    </main>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
