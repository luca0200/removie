<?php
require __DIR__ . '/config.php';

safe_session_start();
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    exit(json_encode([]));
}

try {
    $pdo = db();
    $userId = $_SESSION['user_id'];

    // Get favorites
    $stmt = $pdo->prepare("SELECT id_contenido FROM favoritos WHERE id_usuario = :u");
    $stmt->execute([':u' => $userId]);
    $favorites = $stmt->fetchAll(PDO::FETCH_COLUMN);

    // Get watched
    $stmt = $pdo->prepare("SELECT id_contenido FROM vistas WHERE id_usuario = :u");
    $stmt->execute([':u' => $userId]);
    $watched = $stmt->fetchAll(PDO::FETCH_COLUMN);

    // Get pending
    $stmt = $pdo->prepare("SELECT id_contenido FROM pendientes WHERE id_usuario = :u");
    $stmt->execute([':u' => $userId]);
    $pending = $stmt->fetchAll(PDO::FETCH_COLUMN);

    header('Content-Type: application/json');
    echo json_encode([
        'favorites' => $favorites,
        'watched' => $watched,
        'pending' => $pending
    ]);

} catch (Exception $e) {
    error_log("Error getting user states: " . $e->getMessage());
    http_response_code(500);
    exit(json_encode([]));
}
