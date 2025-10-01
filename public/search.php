<?php
require __DIR__ . '/config.php';
require __DIR__ . '/tmdb_service.php';

$q = trim($_GET['q'] ?? '');
$title = $q ? "Buscar: $q" : 'Buscar';

$pdo = db();
$tmdbService = new TMDbService($pdo);
$rows = [];

if ($q !== '') {
    // Primero buscar en la base de datos
    $stmt = $pdo->prepare("SELECT * FROM contenido WHERE titulo LIKE :q OR descripcion LIKE :q ORDER BY fecha_ultima_actualizacion DESC LIMIT 50");
    $stmt->execute([':q' => "%$q%"]);
    $rows = $stmt->fetchAll();

    // Si no hay resultados en DB -> buscar en TMDb y guardarlos
    if (!$rows) {
        $searchResults = $tmdbService->searchMovies($q, 20);

        if (!empty($searchResults)) {
            // Los resultados ya están guardados en la base de datos por el servicio
            // Volver a consultar la DB para mostrar
            $stmt = $pdo->prepare("SELECT * FROM contenido WHERE titulo LIKE :q OR descripcion LIKE :q ORDER BY fecha_ultima_actualizacion DESC LIMIT 50");
            $stmt->execute([':q' => "%$q%"]);
            $rows = $stmt->fetchAll();
        }
    }
}

include __DIR__ . '/header.php';
?>
<section class="section">
  <h2>Resultados <?= $q ? 'para “'.htmlspecialchars($q).'”' : '' ?></h2>
  <?php if ($q === ''): ?>
    <p>Escribí algo para buscar.</p>
  <?php elseif (!$rows): ?>
    <p>No encontramos nada ni en TMDb.</p>
  <?php else: ?>
    <div class="cards">
      <?php foreach ($rows as $c): ?>
        <?= render_movie_card($c) ?>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>
</section>
<?php include __DIR__ . '/footer.php'; ?>
