<?php
require __DIR__ . '/config.php';

safe_session_start();
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit;
}

// CSRF protection
if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Token CSRF inválido']);
    exit;
}

$id_contenido = (int)($_POST['movie_id'] ?? 0);

if ($id_contenido <= 0) {
    echo json_encode(['success' => false, 'message' => 'ID de contenido inválido']);
    exit;
}

try {
    $pdo = db();

    // Verificar si ya existe el favorito
    $stmt = $pdo->prepare("SELECT id_favorito FROM favoritos WHERE id_usuario = :u AND id_contenido = :c");
    $stmt->execute([':u' => $_SESSION['user_id'], ':c' => $id_contenido]);

    if ($existing = $stmt->fetch()) {
        // Eliminar favorito
        $stmt = $pdo->prepare("DELETE FROM favoritos WHERE id_favorito = :id");
        $stmt->execute([':id' => $existing['id_favorito']]);
        echo json_encode(['success' => true, 'action' => 'removed', 'message' => 'Eliminado de favoritos']);
    } else {
        // Agregar favorito
        $stmt = $pdo->prepare("INSERT INTO favoritos (id_usuario, id_contenido, fecha_agregado) VALUES (:u, :c, NOW())");
        $stmt->execute([':u' => $_SESSION['user_id'], ':c' => $id_contenido]);
        echo json_encode(['success' => true, 'action' => 'added', 'message' => 'Agregado a favoritos']);
    }

} catch (Exception $e) {
    error_log("Error toggle favorite: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Error del servidor']);
}
