<?php
require __DIR__ . '/config.php';

safe_session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

$title = 'Mi Perfil';
include __DIR__ . '/header.php';

$pdo = db();
$user_id = $_SESSION['user_id'];

// Obtener información del usuario
$stmt = $pdo->prepare("SELECT email, nombre_usuario, fecha_registro FROM usuarios WHERE id_usuario = :id");
$stmt->execute([':id' => $user_id]);
$user = $stmt->fetch();

// Obtener estadísticas del usuario
$stats = [
    'favoritos' => 0,
    'vistos' => 0,
    'pendientes' => 0,
    'resenas' => 0
];

// Contar favoritos
$fav_stmt = $pdo->prepare("SELECT COUNT(*) as count FROM favoritos WHERE id_usuario = :id");
$fav_stmt->execute([':id' => $user_id]);
$stats['favoritos'] = $fav_stmt->fetch()['count'];

// Contar vistos
$watched_stmt = $pdo->prepare("SELECT COUNT(*) as count FROM vistas WHERE id_usuario = :id");
$watched_stmt->execute([':id' => $user_id]);
$stats['vistos'] = $watched_stmt->fetch()['count'];

// Contar pendientes
$pending_stmt = $pdo->prepare("SELECT COUNT(*) as count FROM pendientes WHERE id_usuario = :id");
$pending_stmt->execute([':id' => $user_id]);
$stats['pendientes'] = $pending_stmt->fetch()['count'];

// Contar reseñas
$reviews_stmt = $pdo->prepare("SELECT COUNT(*) as count FROM calificaciones WHERE id_usuario = :id AND comentario IS NOT NULL");
$reviews_stmt->execute([':id' => $user_id]);
$stats['resenas'] = $reviews_stmt->fetch()['count'];
?>

<section class="section">
  <div class="profile-container">
    <div class="profile-header">
      <h2>Mi Perfil</h2>
      <div class="profile-info">
        <div class="profile-avatar">
          <?= strtoupper(substr($user['nombre_usuario'] ?: $user['email'], 0, 1)) ?>
        </div>
        <div class="profile-details">
          <h3><?= htmlspecialchars($user['nombre_usuario'] ?: 'Usuario') ?></h3>
          <p><?= htmlspecialchars($user['email']) ?></p>
          <small>Miembro desde <?= date('d/m/Y', strtotime($user['fecha_registro'])) ?></small>
        </div>
      </div>
    </div>

    <div class="profile-stats">
      <h3>Mis Estadísticas</h3>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number"><?= $stats['favoritos'] ?></div>
          <div class="stat-label">Favoritos</div>
        </div>
        <div class="stat-card">
          <div class="stat-number"><?= $stats['vistos'] ?></div>
          <div class="stat-label">Vistos</div>
        </div>
        <div class="stat-card">
          <div class="stat-number"><?= $stats['pendientes'] ?></div>
          <div class="stat-label">Pendientes</div>
        </div>
        <div class="stat-card">
          <div class="stat-number"><?= $stats['resenas'] ?></div>
          <div class="stat-label">Reseñas</div>
        </div>
      </div>
    </div>

    <div class="profile-actions">
      <h3>Mis Listas</h3>
      <div class="action-buttons">
        <a href="favoritos.php" class="btn">⭐ Favoritos (<?= $stats['favoritos'] ?>)</a>
        <a href="vistos.php" class="btn secondary">✅ Vistos (<?= $stats['vistos'] ?>)</a>
        <a href="pendientes.php" class="btn secondary">⏰ Pendientes (<?= $stats['pendientes'] ?>)</a>
        <a href="index.php" class="btn outline">Explorar Películas</a>
        <a href="logout.php" class="btn outline">Cerrar Sesión</a>
      </div>
    </div>
  </div>
</section>

<?php include __DIR__ . '/footer.php'; ?>
