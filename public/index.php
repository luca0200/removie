<?php
require __DIR__ . '/config.php';
require __DIR__ . '/tmdb_service.php';

$title = 'Re-movie';
include __DIR__ . '/header.php';

$pdo = db();
$tmdbService = new TMDbService($pdo);

// Obtener contenido de la base de datos
$tendencias = $tmdbService->getMoviesFromDatabase(8, 'calificacion_promedio');
$recientes = $tmdbService->getMoviesFromDatabase(12, 'fecha_ultima_actualizacion');
$populares = $tmdbService->getMoviesFromDatabase(20, 'calificacion_promedio');

// Si no hay contenido en la base de datos, obtener películas trending directamente de TMDb
if (empty($tendencias) && empty($recientes) && empty($populares)) {
    echo "<div style='text-align: center; padding: 20px;'>";
    echo "<h3>Cargando películas trending...</h3>";
    echo "<p>Obteniendo contenido desde TMDb...</p>";
    echo "</div>";

    // Obtener películas trending y populares directamente
    $trendingMovies = $tmdbService->getTrendingMoviesDirect(8);
    $popularMovies = $tmdbService->getPopularMoviesOptimized(12);

    // Guardar las películas en la base de datos para uso futuro
    foreach ($trendingMovies as $movie) {
        $tmdbService->saveMovie([
            'tmdb_id' => $movie['id_contenido'],
            'titulo' => $movie['titulo'],
            'tipo' => $movie['tipo'],
            'descripcion' => $movie['descripcion'],
            'poster_url' => $movie['poster_url'],
            'trailer_url' => $movie['trailer_url'],
            'calificacion_promedio' => $movie['calificacion_promedio'],
            'fecha_lanzamiento' => $movie['fecha_lanzamiento'],
            'idioma_original' => 'es'
        ]);
    }

    foreach ($popularMovies as $movie) {
        $tmdbService->saveMovie([
            'tmdb_id' => $movie['id_contenido'],
            'titulo' => $movie['titulo'],
            'tipo' => $movie['tipo'],
            'descripcion' => $movie['descripcion'],
            'poster_url' => $movie['poster_url'],
            'trailer_url' => $movie['trailer_url'],
            'calificacion_promedio' => $movie['calificacion_promedio'],
            'fecha_lanzamiento' => $movie['fecha_lanzamiento'],
            'idioma_original' => 'es'
        ]);
    }

    if (!empty($trendingMovies) || !empty($popularMovies)) {
        echo "<script>window.location.reload();</script>";
    } else {
        echo "<div style='text-align: center; padding: 50px; color: red;'>";
        echo "<h3>Error al cargar películas</h3>";
        echo "<p>No se pudo obtener contenido desde TMDb. Verifica tu conexión a internet.</p>";
        echo "</div>";
    }

    include __DIR__ . '/footer.php';
    exit;
}
?>

<section id="tendencias" class="section">
  <h2>Tendencias</h2>
  <div class="cards">
    <?php foreach ($tendencias as $c): ?>
      <?= render_movie_card($c) ?>
    <?php endforeach; ?>
  </div>
</section>

<section id="recientes" class="section">
  <h2>Recientes</h2>
  <div class="cards">
    <?php foreach ($recientes as $c): ?>
      <?= render_movie_card($c) ?>
    <?php endforeach; ?>
  </div>
</section>

<section id="populares" class="section">
  <h2>Populares</h2>
  <div class="cards">
    <?php foreach ($populares as $c): ?>
      <?= render_movie_card($c) ?>
    <?php endforeach; ?>
  </div>
</section>

<?php include __DIR__ . '/footer.php'; ?>
