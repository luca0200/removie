<?php
require __DIR__ . '/config.php';

safe_session_start();
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    exit(json_encode([]));
}

try {
    $pdo = db();
    $stmt = $pdo->prepare("SELECT id_contenido FROM favoritos WHERE id_usuario = :u ORDER BY fecha_agregado DESC");
    $stmt->execute([':u' => $_SESSION['user_id']]);

    $favorites = $stmt->fetchAll(PDO::FETCH_COLUMN);
    header('Content-Type: application/json');
    echo json_encode($favorites);

} catch (Exception $e) {
    error_log("Error getting favorites: " . $e->getMessage());
    http_response_code(500);
    exit(json_encode([]));
}
