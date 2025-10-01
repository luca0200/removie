<?php
safe_session_start();
require_once 'config.php';
require_once 'tmdb_service.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);
$movieId = $data['movie_id'] ?? null;
$review = trim($data['review'] ?? '');
$rating = $data['rating'] ?? null;

if (!$movieId || !$review || $rating === null) {
    echo json_encode(['success' => false, 'message' => 'ID de película, reseña y calificación requeridos']);
    exit;
}

// Filtros de contenido
$prohibitedWords = ['insulto1', 'insulto2', 'palabramala1', 'palabramala2']; // Lista de palabras prohibidas
$reviewLower = strtolower($review);

foreach ($prohibitedWords as $word) {
    if (strpos($reviewLower, $word) !== false) {
        echo json_encode(['success' => false, 'message' => 'La reseña contiene contenido inapropiado']);
        exit;
    }
}

// Verificar longitud mínima y máxima
if (strlen($review) < 10) {
    echo json_encode(['success' => false, 'message' => 'La reseña debe tener al menos 10 caracteres']);
    exit;
}

if (strlen($review) > 1000) {
    echo json_encode(['success' => false, 'message' => 'La reseña no puede exceder 1000 caracteres']);
    exit;
}

// Verificar calificación válida
if ($rating < 1 || $rating > 10) {
    echo json_encode(['success' => false, 'message' => 'La calificación debe estar entre 1 y 10']);
    exit;
}

$userId = $_SESSION['user_id'];

try {
    // Inicializar TMDbService para actualizar ratings
    $tmdbService = new TMDbService($pdo);

    // Verificar si ya existe una reseña del usuario para esta película
    $stmt = $pdo->prepare("SELECT id_calificacion FROM calificaciones WHERE id_usuario = ? AND id_contenido = ?");
    $stmt->execute([$userId, $movieId]);
    $existing = $stmt->fetch();

    if ($existing) {
        // Actualizar reseña existente
        $stmt = $pdo->prepare("UPDATE calificaciones SET puntuacion = ?, comentario = ?, fecha = CURRENT_TIMESTAMP WHERE id_usuario = ? AND id_contenido = ?");
        $stmt->execute([$rating, $review, $userId, $movieId]);

        // Actualizar rating ponderado de la película
        $tmdbService->updateWeightedRating($movieId);

        echo json_encode(['success' => true, 'action' => 'updated', 'message' => 'Reseña actualizada correctamente']);
    } else {
        // Crear nueva reseña
        $stmt = $pdo->prepare("INSERT INTO calificaciones (id_usuario, id_contenido, puntuacion, comentario) VALUES (?, ?, ?, ?)");
        $stmt->execute([$userId, $movieId, $rating, $review]);

        // Actualizar rating ponderado de la película
        $tmdbService->updateWeightedRating($movieId);

        echo json_encode(['success' => true, 'action' => 'created', 'message' => 'Reseña guardada correctamente']);
    }
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Error de base de datos: ' . $e->getMessage()]);
}
?>
