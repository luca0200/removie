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

// Obtener movie_id de POST o JSON
$movieId = (int)($_POST['movie_id'] ?? 0);

if ($movieId <= 0) {
    echo json_encode(['success' => false, 'message' => 'ID de película inválido']);
    exit;
}

try {
    $pdo = db();
    $userId = $_SESSION['user_id'];

    // Verificar si la película ya está en pendientes
    $stmt = $pdo->prepare("SELECT id_pendiente FROM pendientes WHERE id_usuario = ? AND id_contenido = ?");
    $stmt->execute([$userId, $movieId]);
    $existing = $stmt->fetch();

    if ($existing) {
        // Remover de pendientes
        $stmt = $pdo->prepare("DELETE FROM pendientes WHERE id_usuario = ? AND id_contenido = ?");
        $stmt->execute([$userId, $movieId]);
        echo json_encode(['success' => true, 'action' => 'removed', 'message' => 'Película removida de pendientes']);
    } else {
        // Agregar a pendientes
        $stmt = $pdo->prepare("INSERT INTO pendientes (id_usuario, id_contenido) VALUES (?, ?)");
        $stmt->execute([$userId, $movieId]);
        echo json_encode(['success' => true, 'action' => 'added', 'message' => 'Película agregada a pendientes']);
    }
} catch (Exception $e) {
    error_log("Error toggle pendiente: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Error del servidor']);
}
?>
