<?php
// Database config
$DB_HOST = getenv('DB_HOST') ?: 'localhost';
$DB_USER = getenv('DB_USER') ?: 'root';
$DB_PASS = getenv('DB_PASS') ?: '';
$DB_NAME = getenv('DB_NAME') ?: 'removie';
$DB_CHARSET = 'utf8mb4';

define('CACHE_DAYS', 7); // reimportar si tiene más de 7 días

function db() {
    static $pdo;
    global $DB_HOST, $DB_USER, $DB_PASS, $DB_NAME, $DB_CHARSET;
    if (!$pdo) {
        $dsn = "mysql:host=$DB_HOST;dbname=$DB_NAME;charset=$DB_CHARSET";
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ];
        $pdo = new PDO($dsn, $DB_USER, $DB_PASS, $options);
    }
    return $pdo;
}

/**
 * Inicia la sesión de forma segura, evitando el error de sesión ya activa
 */
function safe_session_start() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
}

function porcentaje_rate($calif_prom) {
    if ($calif_prom === null) return null;
    $p = max(0, min(100, round($calif_prom * 10)));
    return $p;
}

function edad_badge($prom) {
    if ($prom === null) return '+13';
    $p = $prom * 10;
    if ($p >= 85) return '+16';
    if ($p >= 70) return '+13';
    if ($p >= 50) return '+8';
    return 'ATP';
}

function render_movie_card($c, $showActions = true) {
    $rate = porcentaje_rate($c['calificacion_promedio']);
    ob_start();
    ?>
    <div class="card-container">
      <a class="card" href="detalle.php?id=<?= $c['id_contenido'] ?>">
        <div class="badge"><?= edad_badge($c['calificacion_promedio']) ?></div>
        <?php if ($c['poster_url']): ?>
          <img src="<?= htmlspecialchars($c['poster_url']) ?>"
               alt="<?= htmlspecialchars($c['titulo']) ?>"
               loading="lazy"
               onload="this.classList.add('loaded')">
        <?php else: ?>
          <div class="poster-fallback">
            <div class="image-placeholder">
              <span>Cargando...</span>
            </div>
          </div>
        <?php endif; ?>
        <div class="card-body">
          <div class="title"><?= htmlspecialchars($c['titulo']) ?></div>
          <?php if ($rate !== null): ?>
            <div class="rate"><strong><?= $rate ?>%</strong> RATE</div>
          <?php endif; ?>
        </div>
      </a>

    </div>
    <?php
    return ob_get_clean();
}
