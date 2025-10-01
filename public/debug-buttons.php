<?php
require __DIR__ . '/config.php';

// Simular una sesión de usuario
session_start();
$_SESSION['user_id'] = 1; // Usuario de prueba

// Simular una película
$movie_id = 1;

// Verificar estados reales de la base de datos
$pdo = db();
$user_actions = [
    'is_favorite' => false,
    'is_watched' => false,
    'is_pending' => false
];

if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];

    // Favoritos
    $fav_stmt = $pdo->prepare("SELECT id_favorito FROM favoritos WHERE id_usuario = ? AND id_contenido = ?");
    $fav_stmt->execute([$user_id, $movie_id]);
    $user_actions['is_favorite'] = !empty($fav_stmt->fetch());

    // Vistos
    $watched_stmt = $pdo->prepare("SELECT id_visto FROM vistas WHERE id_usuario = ? AND id_contenido = ?");
    $watched_stmt->execute([$user_id, $movie_id]);
    $user_actions['is_watched'] = !empty($watched_stmt->fetch());

    // Pendientes
    $pending_stmt = $pdo->prepare("SELECT id_pendiente FROM pendientes WHERE id_usuario = ? AND id_contenido = ?");
    $pending_stmt->execute([$user_id, $movie_id]);
    $user_actions['is_pending'] = !empty($pending_stmt->fetch());
}

echo "<h1>Debug de Estados de Botones</h1>";
echo "<h2>Estados desde la base de datos:</h2>";
echo "<pre>";
print_r($user_actions);
echo "</pre>";

echo "<h2>HTML que se generaría:</h2>";
echo "<div style='border: 1px solid #ccc; padding: 10px; margin: 10px 0;'>";

echo "<button class='btn outline favorite-btn " . ($user_actions['is_favorite'] ? 'active' : '') . "' data-movie-id='$movie_id' data-is-favorite='" . ($user_actions['is_favorite'] ? 'true' : 'false') . "' " . ($user_actions['is_favorite'] ? 'style="background: #ff6b6b !important; color: white !important; border-color: #ff6b6b !important; border-width: 2px !important; font-weight: bold !important;"' : '') . ">";
echo $user_actions['is_favorite'] ? '★ En favoritos' : '☆ Agregar a favoritos';
echo "</button>";

echo "<button class='btn outline watched-btn " . ($user_actions['is_watched'] ? 'active' : '') . "' data-movie-id='$movie_id' data-is-watched='" . ($user_actions['is_watched'] ? 'true' : 'false') . "' " . ($user_actions['is_watched'] ? 'style="background: #4ecdc4 !important; color: white !important; border-color: #4ecdc4 !important; border-width: 2px !important; font-weight: bold !important;"' : '') . ">";
echo $user_actions['is_watched'] ? '✓ Visto' : '○ Marcar como visto';
echo "</button>";

echo "<button class='btn outline pending-btn " . ($user_actions['is_pending'] ? 'active' : '') . "' data-movie-id='$movie_id' data-is-pending='" . ($user_actions['is_pending'] ? 'true' : 'false') . "' " . ($user_actions['is_pending'] ? 'style="background: #45b7d1 !important; color: white !important; border-color: #45b7d1 !important; border-width: 2px !important; font-weight: bold !important;"' : '') . ">";
echo $user_actions['is_pending'] ? '⏰ En pendientes' : '⏱ Agregar a pendientes';
echo "</button>";

echo "</div>";

echo "<h2>Debug JavaScript:</h2>";
echo "<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('=== DEBUG INFO ===');
    console.log('Estados de botones:', " . json_encode($user_actions) . ");

    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(btn => {
        console.log('Botón:', {
            tag: btn.tagName,
            className: btn.className,
            id: btn.id,
            dataMovieId: btn.getAttribute('data-movie-id'),
            dataIsFavorite: btn.getAttribute('data-is-favorite'),
            dataIsWatched: btn.getAttribute('data-is-watched'),
            dataIsPending: btn.getAttribute('data-is-pending'),
            textContent: btn.textContent.trim(),
            computedStyle: window.getComputedStyle(btn).backgroundColor
        });
    });
});
</script>";
