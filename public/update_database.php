<?php
/**
 * Script para actualizar la base de datos semanalmente con contenido de TMDb
 * Este script debe ejecutarse automáticamente mediante cron job
 */

require __DIR__ . '/config.php';
require __DIR__ . '/tmdb_service.php';

// Configurar para que no muestre errores HTML en modo CLI
if (php_sapi_name() === 'cli') {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    // Si se ejecuta desde web, mostrar página de estado
    echo "<h1>Actualización semanal de base de datos</h1>";
    echo "<pre>";
}

try {
    $pdo = db();
    $tmdbService = new TMDbService($pdo);

    echo "Iniciando actualización de base de datos...\n";

    // Verificar si realmente necesita actualización
    if (!$tmdbService->needsUpdate()) {
        echo "La base de datos ya tiene contenido reciente. No es necesario actualizar.\n";
        exit(0);
    }

    echo "Obteniendo películas trending de TMDb...\n";

    // Obtener películas trending
    $trendingMovies = $tmdbService->getTrendingMovies(25);
    echo "✅ Procesadas " . count($trendingMovies) . " películas trending\n";

    // Obtener películas populares adicionales
    echo "Obteniendo películas populares adicionales...\n";
    $popularMovies = $tmdbService->getPopularMovies(15);
    echo "✅ Procesadas " . count($popularMovies) . " películas populares\n";

    // Combinar y eliminar duplicados
    $allMovies = array_merge($trendingMovies, $popularMovies);
    $uniqueMovies = [];
    $tmdbIds = [];

    foreach ($allMovies as $movie) {
        if (!in_array($movie['tmdb_id'], $tmdbIds)) {
            $uniqueMovies[] = $movie;
            $tmdbIds[] = $movie['tmdb_id'];
        }
    }

    echo "📊 Total de películas únicas procesadas: " . count($uniqueMovies) . "\n";

    // Verificar el estado final de la base de datos
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM contenido");
    $result = $stmt->fetch();
    $totalMovies = $result['total'];

    echo "\n=== RESUMEN DE ACTUALIZACIÓN ===\n";
    echo "Películas en base de datos: $totalMovies\n";
    echo "Películas actualizadas en esta ejecución: " . count($uniqueMovies) . "\n";
    echo "Última actualización: " . date('Y-m-d H:i:s') . "\n";
    echo "✅ Actualización completada exitosamente\n";

    if (php_sapi_name() !== 'cli') {
        echo "</pre>";
        echo "<p><a href='index.php'>Volver al inicio</a></p>";
    }

} catch (Exception $e) {
    $error = "Error durante la actualización: " . $e->getMessage();
    echo $error . "\n";

    if (php_sapi_name() !== 'cli') {
        echo "</pre>";
        echo "<p style='color: red;'>$error</p>";
        echo "<p><a href='index.php'>Volver al inicio</a></p>";
    }

    exit(1);
}

class TMDbService {
    private $apiKey;
    private $baseUrl = 'https://api.themoviedb.org/3';
    private $imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    private $pdo;

    public function __construct($pdo, $apiKey = 'eb8525892bb19b238dd289e0cd30cd05') {
        $this->apiKey = $apiKey;
        $this->pdo = $pdo;
    }

    public function getTrendingMovies($limit = 20) {
        $endpoint = "/trending/movie/week";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    public function getPopularMovies($limit = 20) {
        $endpoint = "/movie/popular";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    private function processMovies($movies) {
        $processedMovies = [];

        foreach ($movies as $movie) {
            $tmdbId = $movie['id'];
            $titulo = $movie['title'] ?? $movie['name'] ?? 'Título desconocido';
            $poster = isset($movie['poster_path']) ? $this->imageBaseUrl . $movie['poster_path'] : null;
            $rating = $movie['vote_average'] ?? null;

            // Obtener detalles adicionales
            $details = $this->getMovieDetails($tmdbId);
            $descripcion = $details['overview'] ?? null;

            // Obtener trailer
            $trailer = $this->getMovieTrailer($tmdbId);

            // Determinar tipo
            $tipo = isset($movie['media_type']) ? $movie['media_type'] : 'pelicula';
            if ($tipo === 'tv') {
                $tipo = 'serie';
            }

            // Guardar en base de datos
            $this->saveMovie([
                'tmdb_id' => $tmdbId,
                'titulo' => $titulo,
                'tipo' => $tipo,
                'descripcion' => $descripcion,
                'poster_url' => $poster,
                'trailer_url' => $trailer,
                'calificacion_promedio' => $rating,
                'fecha_lanzamiento' => isset($movie['release_date']) ? $movie['release_date'] : null,
                'idioma_original' => $movie['original_language'] ?? null
            ]);

            $processedMovies[] = [
                'tmdb_id' => $tmdbId,
                'titulo' => $titulo,
                'tipo' => $tipo,
                'descripcion' => $descripcion,
                'poster_url' => $poster,
                'trailer_url' => $trailer,
                'calificacion_promedio' => $rating,
                'fecha_lanzamiento' => isset($movie['release_date']) ? $movie['release_date'] : null
            ];
        }

        return $processedMovies;
    }

    private function getMovieDetails($tmdbId) {
        $endpoint = "/movie/{$tmdbId}";
        return $this->makeRequest($endpoint) ?: [];
    }

    private function getMovieTrailer($tmdbId) {
        $endpoint = "/movie/{$tmdbId}/videos";
        $data = $this->makeRequest($endpoint);

        if ($data && !empty($data['results'])) {
            foreach ($data['results'] as $video) {
                if ($video['type'] === 'Trailer' && $video['site'] === 'YouTube') {
                    return "https://www.youtube.com/watch?v=" . $video['key'];
                }
            }
        }

        return null;
    }

    private function saveMovie($movieData) {
        try {
            $stmt = $this->pdo->prepare("
                INSERT INTO contenido (
                    tmdb_id, titulo, tipo, descripcion, fecha_lanzamiento,
                    poster_url, trailer_url, idioma_original, calificacion_promedio,
                    fecha_ultima_actualizacion
                ) VALUES (
                    :tmdb_id, :titulo, :tipo, :descripcion, :fecha_lanzamiento,
                    :poster_url, :trailer_url, :idioma_original, :calificacion_promedio,
                    NOW()
                ) ON DUPLICATE KEY UPDATE
                    titulo = VALUES(titulo),
                    descripcion = VALUES(descripcion),
                    fecha_lanzamiento = VALUES(fecha_lanzamiento),
                    poster_url = VALUES(poster_url),
                    trailer_url = VALUES(trailer_url),
                    idioma_original = VALUES(idioma_original),
                    calificacion_promedio = VALUES(calificacion_promedio),
                    fecha_ultima_actualizacion = NOW()
            ");

            $stmt->execute([
                ':tmdb_id' => $movieData['tmdb_id'],
                ':titulo' => $movieData['titulo'],
                ':tipo' => $movieData['tipo'],
                ':descripcion' => $movieData['descripcion'],
                ':fecha_lanzamiento' => $movieData['fecha_lanzamiento'],
                ':poster_url' => $movieData['poster_url'],
                ':trailer_url' => $movieData['trailer_url'],
                ':idioma_original' => $movieData['idioma_original'],
                ':calificacion_promedio' => $movieData['calificacion_promedio']
            ]);

            return $this->pdo->lastInsertId();

        } catch (Exception $e) {
            error_log("Error saving movie {$movieData['tmdb_id']}: " . $e->getMessage());
            return false;
        }
    }

    private function makeRequest($endpoint, $params = []) {
        $params['api_key'] = $this->apiKey;
        $params['language'] = 'es-ES';

        $url = $this->baseUrl . $endpoint . '?' . http_build_query($params);

        $context = stream_context_create([
            'http' => [
                'timeout' => 10,
                'user_agent' => 'Re-movie/1.0'
            ]
        ]);

        $response = @file_get_contents($url, false, $context);

        if ($response === false) {
            error_log("TMDb API request failed: $url");
            return null;
        }

        return json_decode($response, true);
    }

    public function needsUpdate() {
        $stmt = $this->pdo->prepare("
            SELECT COUNT(*) as count
            FROM contenido
            WHERE fecha_ultima_actualizacion > DATE_SUB(NOW(), INTERVAL 7 DAY)
        ");

        $stmt->execute();
        $result = $stmt->fetch();

        return $result['count'] < 10;
    }
}
