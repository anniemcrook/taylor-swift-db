<?php
require __DIR__ . '/_bootstrap.php';

// Only the finished ranked result is ever sent here — the
// in-progress bracket (mid-play state, undo history) stays in
// localStorage always, even while logged in. One POST per completed
// tournament; tournament.js guards against sending the same result
// twice via a syncedToServer flag in its own saved state.
$recordingIds = $apiInput['recording_ids'] ?? [];
if (!is_array($recordingIds) || $recordingIds === []) {
    api_fail(400, 'recording_ids must be a non-empty array.');
}

$checkStmt = $pdo->prepare('SELECT 1 FROM recordings WHERE recording_id = :id');
$validRecordingIds = [];
foreach ($recordingIds as $recordingId) {
    $recordingId = (int) $recordingId;
    $checkStmt->execute(['id' => $recordingId]);
    if ($checkStmt->fetch()) {
        $validRecordingIds[] = $recordingId;
    }
}
if ($validRecordingIds === []) {
    api_fail(400, 'None of those recordings exist.');
}

$pdo->beginTransaction();
$insertResultStmt = $pdo->prepare('INSERT INTO tournament_results (user_id) VALUES (:userId)');
$insertResultStmt->execute(['userId' => $apiUser['user_id']]);
$resultId = (int) $pdo->lastInsertId();

$insertRankingStmt = $pdo->prepare('INSERT INTO tournament_result_rankings (tournament_result_id, `rank`, recording_id) VALUES (:resultId, :rank, :recordingId)');
foreach ($validRecordingIds as $index => $recordingId) {
    $insertRankingStmt->execute(['resultId' => $resultId, 'rank' => $index + 1, 'recordingId' => $recordingId]);
}
$pdo->commit();

echo json_encode(['ok' => true, 'tournament_result_id' => $resultId]);
