<?php
// Shared setup for every JSON endpoint under backend/api/. Every one
// of these changes a logged-in user's own data, so the login check,
// the CSRF check, and the DB connection are identical across all of
// them — done once here rather than three times over.
require __DIR__ . '/../auth.php';
require __DIR__ . '/../config.php';

header('Content-Type: application/json');

function api_fail(int $httpStatus, string $message): void
{
    http_response_code($httpStatus);
    echo json_encode(['ok' => false, 'error' => $message]);
    exit;
}

$apiUser = current_user();
if (!$apiUser) {
    api_fail(401, 'You need to be logged in.');
}

$apiInput = json_decode((string) file_get_contents('php://input'), true);
if (!is_array($apiInput)) {
    $apiInput = [];
}

if (!verify_csrf_token($apiInput['csrf_token'] ?? null)) {
    api_fail(403, 'Your session expired — please refresh the page and try again.');
}

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    api_fail(500, 'Database connection failed.');
}
