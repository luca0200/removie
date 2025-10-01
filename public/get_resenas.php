<?php
require_once 'config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit;
}

$movieId = $_GET['movie_id'] ?? null;

if (!$movieId) {
    echo json_encode(['success' => false, 'message' => 'ID de película requerido']);
    exit;
}

try {
    // Obtener reseñas con información del usuario
    $stmt = $pdo->prepare("
        SELECT c.comentario, c.puntuacion, c.fecha, u.nombre_usuario, u.avatar_url
        FROM calificaciones c
        JOIN usuarios u ON c.id_usuario = u.id_usuario
        WHERE c.id_contenido = ?
        ORDER BY c.fecha DESC
    ");
    $stmt->execute([$movieId]);
    $reviews = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['success' => true, 'reviews' => $reviews]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Error de base de datos: ' . $e->getMessage()]);
}
?>
