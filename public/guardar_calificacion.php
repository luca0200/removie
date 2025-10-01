<?php
require __DIR__ . '/config.php';

session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Método no permitido');
}

// CSRF protection
if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
    http_response_code(403);
    exit('Token CSRF inválido');
}

$id_contenido = (int)($_POST['id_contenido'] ?? 0);
$puntuacion = (float)($_POST['puntuacion'] ?? 0);
$comentario = trim($_POST['comentario'] ?? '');

if ($id_contenido <= 0 || $puntuacion < 1 || $puntuacion > 10) {
    header("Location: detalle.php?id=$id_contenido");
    exit;
}

try {
    $pdo = db();

    // Verificar si el usuario ya calificó este contenido
    $stmt = $pdo->prepare("SELECT id_calificacion FROM calificaciones WHERE id_usuario = :u AND id_contenido = :c");
    $stmt->execute([':u' => $_SESSION['user_id'], ':c' => $id_contenido]);

    if ($existing = $stmt->fetch()) {
        // Actualizar calificación existente
        $stmt = $pdo->prepare("UPDATE calificaciones SET puntuacion = :p, comentario = :m, fecha_calificacion = NOW() WHERE id_calificacion = :id");
        $stmt->execute([
            ':p' => $puntuacion,
            ':m' => $comentario ?: null,
            ':id' => $existing['id_calificacion']
        ]);
    } else {
        // Insertar nueva calificación
        $stmt = $pdo->prepare("INSERT INTO calificaciones (id_usuario, id_contenido, puntuacion, comentario, fecha_calificacion) VALUES (:u, :c, :p, :m, NOW())");
        $stmt->execute([
            ':u' => $_SESSION['user_id'],
            ':c' => $id_contenido,
            ':p' => $puntuacion,
            ':m' => $comentario ?: null
        ]);
    }

    // actualizar promedio cacheado en contenido
    $upd = $pdo->prepare("UPDATE contenido SET calificacion_promedio = (SELECT AVG(puntuacion) FROM calificaciones WHERE id_contenido = :c) WHERE id_contenido = :c");
    $upd->execute([':c' => $id_contenido]);

    header("Location: detalle.php?id=$id_contenido");
    exit;

} catch (Exception $e) {
    error_log("Error guardando calificación: " . $e->getMessage());
    header("Location: detalle.php?id=$id_contenido");
    exit;
}
