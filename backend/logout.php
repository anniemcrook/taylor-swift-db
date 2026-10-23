<?php
require __DIR__ . '/auth.php';

log_out_user();
header('Location: index.php');
exit;
