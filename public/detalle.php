<?php
require __DIR__ . '/config.php';
require __DIR__ . '/tmdb_service.php';
$id = (int)($_GET['id'] ?? 0);
$pdo = db();
$tmdbService = new TMDbService($pdo);

$stmt = $pdo->prepare("SELECT * FROM contenido WHERE id_contenido = :id");
$stmt->execute([':id' => $id]);
$c = $stmt->fetch();
if (!$c) { http_response_code(404); $title = 'No encontrado'; include __DIR__.'header.php'; echo "<p>No encontrado</p>"; include __DIR__.'/footer.php'; exit; }

// El rating ya está calculado y guardado en la base de datos (sistema ponderado)
// No necesitamos recalcularlo aquí, ya se actualiza automáticamente cuando se agregan reseñas
$avg = $c['calificacion_promedio'];
$rate = porcentaje_rate($avg);

// Obtener datos de reseñas para mostrar estadísticas
$cal = $pdo->prepare("SELECT AVG(puntuacion) as avgp, COUNT(*) as cnt FROM calificaciones WHERE id_contenido = :id");
$cal->execute([':id'=>$id]);
$agg = $cal->fetch();

// Obtener reseñas
$reviews_stmt = $pdo->prepare("
    SELECT c.comentario, c.puntuacion, c.fecha, u.nombre_usuario, u.avatar_url
    FROM calificaciones c
    JOIN usuarios u ON c.id_usuario = u.id_usuario
    WHERE c.id_contenido = ?
    ORDER BY c.fecha DESC
");
$reviews_stmt->execute([$id]);
$reviews = $reviews_stmt->fetchAll();

// Verificar si el usuario actual ya tiene esta película en favoritos, vistos o pendientes
$user_actions = [
    'is_favorite' => false,
    'is_watched' => false,
    'is_pending' => false
];

if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];

    // Favoritos
    $fav_stmt = $pdo->prepare("SELECT id_favorito FROM favoritos WHERE id_usuario = ? AND id_contenido = ?");
    $fav_stmt->execute([$user_id, $id]);
    $user_actions['is_favorite'] = !empty($fav_stmt->fetch());

    // Vistos
    $watched_stmt = $pdo->prepare("SELECT id_visto FROM vistas WHERE id_usuario = ? AND id_contenido = ?");
    $watched_stmt->execute([$user_id, $id]);
    $user_actions['is_watched'] = !empty($watched_stmt->fetch());

    // Pendientes
    $pending_stmt = $pdo->prepare("SELECT id_pendiente FROM pendientes WHERE id_usuario = ? AND id_contenido = ?");
    $pending_stmt->execute([$user_id, $id]);
    $user_actions['is_pending'] = !empty($pending_stmt->fetch());
}

$title = $c['titulo'];
include __DIR__ . '/header.php';
?>
<section class="section detail">
  <div class="detail-grid">
    <div class="poster-col">
      <?php if ($c['poster_url']): ?>
        <img class="poster-lg" src="<?= htmlspecialchars($c['poster_url']) ?>" alt="<?= htmlspecialchars($c['titulo']) ?>">
      <?php endif; ?>
      <div class="age"><?= edad_badge($avg) ?></div>
    </div>
    <div class="info-col">
      <h1 class="detail-title"><?= htmlspecialchars($c['titulo']) ?></h1>
      <?php if ($rate !== null): ?><div class="rate-lg"><strong><?= $rate ?>%</strong> RATE</div><?php endif; ?>
      <?php if ($c['descripcion']): ?><p class="descripcion"><?= nl2br(htmlspecialchars($c['descripcion'])) ?></p><?php endif; ?>

      <?php if (isset($_SESSION['user_id'])): ?>
      <div class="actions">
        <?php if ($c['trailer_url']): ?>
          <a class="btn" href="<?= htmlspecialchars($c['trailer_url']) ?>" target="_blank" rel="noreferrer">Ver </a>
        <?php endif; ?>
        <button class="btn outline favorite-btn <?= $user_actions['is_favorite'] ? 'active' : '' ?>" data-movie-id="<?= $c['id_contenido'] ?>" data-is-favorite="<?= $user_actions['is_favorite'] ? 'true' : 'false' ?>">
          <?= $user_actions['is_favorite'] ? '★ En favoritos' : '☆ Agregar a favoritos' ?>
        </button>
        <button class="btn outline watched-btn <?= $user_actions['is_watched'] ? 'active' : '' ?>" data-movie-id="<?= $c['id_contenido'] ?>" data-is-watched="<?= $user_actions['is_watched'] ? 'true' : 'false' ?>">
          <?= $user_actions['is_watched'] ? '✓ Visto' : '○ Marcar como visto' ?>
        </button>
        <button class="btn outline pending-btn <?= $user_actions['is_pending'] ? 'active' : '' ?>" data-movie-id="<?= $c['id_contenido'] ?>" data-is-pending="<?= $user_actions['is_pending'] ? 'true' : 'false' ?>">
          <?= $user_actions['is_pending'] ? '⏰ En pendientes' : '⏱ Agregar a pendientes' ?>
        </button>
        <a class="btn secondary" href="perfil.php">Mi perfil</a>
      </div>
      <?php endif; ?>

      <?php if (isset($_SESSION['user_id'])): ?>
      <div class="opinion">
        <label for="opinion">Escribe tu reseña:</label>
        <form action="guardar_resena.php" method="post" class="rating-form">
          <input type="hidden" name="id_contenido" value="<?= $c['id_contenido'] ?>">
          <input type="hidden" name="csrf_token" value="<?= $_SESSION['csrf_token'] ?? '' ?>">
          <div class="stars">
            <?php for ($i=1; $i<=10; $i++): ?>
              <label>
                <input type="radio" name="rating" value="<?= $i ?>" required> <?= $i ?>
              </label>
            <?php endfor; ?>
          </div>
          <textarea name="review" id="opinion" placeholder="Escribe tu reseña aquí..." rows="4" maxlength="1000" minlength="10"></textarea>
          <button type="submit" class="btn">Publicar reseña</button>
        </form>
      </div>
      <?php endif; ?>

      <?php if ($agg['cnt'] ?? 0): ?>
        <div class="meta">Basado en <?= (int)$agg['cnt'] ?> reseñas.</div>
      <?php endif; ?>

      <?php if (!empty($reviews)): ?>
      <div class="reviews-section">
        <h3>Reseñas de usuarios</h3>
        <div class="reviews-list">
          <?php foreach ($reviews as $review): ?>
          <div class="review-item">
            <div class="review-header">
              <div class="review-user">
                <?php if ($review['avatar_url']): ?>
                  <img src="<?= htmlspecialchars($review['avatar_url']) ?>" alt="Avatar" class="user-avatar">
                <?php else: ?>
                  <div class="user-avatar-placeholder">
                    <?= strtoupper(substr($review['nombre_usuario'], 0, 1)) ?>
                  </div>
                <?php endif; ?>
                <span class="username"><?= htmlspecialchars($review['nombre_usuario']) ?></span>
              </div>
              <div class="review-rating">
                <span class="rating-stars">
                  <?php for ($i = 1; $i <= 10; $i++): ?>
                  <span class="star <?= $i <= $review['puntuacion'] ? 'filled' : '' ?>">★</span>
                  <?php endfor; ?>
                </span>
                <span class="rating-number"><?= $review['puntuacion'] ?>/10</span>
              </div>
            </div>
            <div class="review-content">
              <p><?= htmlspecialchars($review['comentario']) ?></p>
              <small class="review-date"><?= date('d/m/Y H:i', strtotime($review['fecha'])) ?></small>
            </div>
          </div>
          <?php endforeach; ?>
        </div>
      </div>
      <?php endif; ?>
    </div>
  </div>
</section>
<?php include __DIR__ . '/footer.php'; ?>


