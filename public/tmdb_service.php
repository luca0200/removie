    <?php
/**
 * Servicio TMDb para Re-movie
 * Maneja la obtención y almacenamiento de datos de películas desde TMDb API
 */

require_once __DIR__ . '/cache_helper.php';

class TMDbService {

    /**
     * Obtiene la URL del trailer de una película o serie desde TMDb por id
     * @param int $tmdbId
     * @param string $tipo 'movie' o 'tv'
     * @return string|null
     */
    public function getTrailerUrl($tmdbId, $tipo = 'movie') {
        if ($tipo === 'tv') {
            $endpoint = "/tv/{$tmdbId}/videos";
        } else {
            $endpoint = "/movie/{$tmdbId}/videos";
        }
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

    /**
     * Busca el trailer en TMDb por título y tipo (movie/tv)
     * @param string $titulo
     * @param string $tipo 'movie' o 'tv'
     * @return string|null
     */
    public function getTrailerUrlByTitle($titulo, $tipo = 'movie') {
        $endpoint = $tipo === 'tv' ? '/search/tv' : '/search/movie';
        $params = ['query' => $titulo];
        $data = $this->makeRequest($endpoint, $params);
        if ($data && !empty($data['results'])) {
            $tmdbId = $data['results'][0]['id'];
            return $this->getTrailerUrl($tmdbId, $tipo);
        }
        return null;
    }
    private $apiKey;
    private $baseUrl = 'https://api.themoviedb.org/3';
    private $imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    private $pdo;
    private $cache;

    public function __construct($pdo, $apiKey = 'eb8525892bb19b238dd289e0cd30cd05') {
        $this->apiKey = $apiKey;
        $this->pdo = $pdo;
        $this->cache = new CacheHelper();
    }

    /**
     * Obtiene películas trending de la semana
     */
    public function getTrendingMovies($limit = 20) {
        $endpoint = "/trending/movie/week";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    /**
     * Obtiene películas populares
     */
    public function getPopularMovies($limit = 20) {
        $endpoint = "/movie/popular";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    /**
     * Obtiene películas populares ordenadas por popularidad TMDb
     */
    public function getPopularMoviesByPopularity($limit = 20) {
        $endpoint = "/movie/popular";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        // Ordenar por popularidad (de mayor a menor)
        usort($data['results'], function($a, $b) {
            return $b['popularity'] <=> $a['popularity'];
        });

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    /**
     * Obtiene películas populares optimizadas (sin detalles adicionales)
     * Para mejorar el rendimiento en la página principal
     */
    public function getPopularMoviesOptimized($limit = 20) {
        $endpoint = "/movie/popular";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        // Ordenar por popularidad (de mayor a menor)
        usort($data['results'], function($a, $b) {
            return $b['popularity'] <=> $a['popularity'];
        });

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMoviesOptimized($movies);
    }

    /**
     * Busca películas por título
     */
    public function searchMovies($query, $limit = 20) {
        $endpoint = "/search/movie";
        $params = ['query' => $query];
        $data = $this->makeRequest($endpoint, $params);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMovies($movies);
    }

    /**
     * Procesa y guarda películas en la base de datos
     */
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

            // Determinar tipo (película o serie)
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
                'id_contenido' => $tmdbId, // Usamos tmdb_id como identificador temporal
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

    /**
     * Obtiene detalles de una película específica
     */
    private function getMovieDetails($tmdbId) {
        $endpoint = "/movie/{$tmdbId}";
        return $this->makeRequest($endpoint) ?: [];
    }

    /**
     * Obtiene el trailer de una película
     */
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

    /**
     * Guarda una película en la base de datos
     */
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

    /**
     * Realiza una petición a la API de TMDb con cache
     */
    private function makeRequest($endpoint, $params = []) {
        $params['api_key'] = $this->apiKey;
        $params['language'] = 'es-ES';

        $url = $this->baseUrl . $endpoint . '?' . http_build_query($params);
        $cacheKey = 'tmdb_' . md5($url);

        return $this->cache->getOrSet($cacheKey, function() use ($url) {
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
        }, 3600); // Cache por 1 hora
    }

    /**
     * Verifica si necesita actualizar datos (más de 7 días)
     */
    public function needsUpdate() {
        $stmt = $this->pdo->prepare("
            SELECT COUNT(*) as count
            FROM contenido
            WHERE fecha_ultima_actualizacion > DATE_SUB(NOW(), INTERVAL 7 DAY)
        ");

        $stmt->execute();
        $result = $stmt->fetch();

        return $result['count'] < 10; // Si hay menos de 10 películas recientes, necesita actualización
    }

    /**
     * Obtiene películas desde la base de datos
     */
    public function getMoviesFromDatabase($limit = 50, $orderBy = 'fecha_ultima_actualizacion') {
        $allowedOrders = ['fecha_ultima_actualizacion', 'calificacion_promedio', 'titulo'];
        $orderBy = in_array($orderBy, $allowedOrders) ? $orderBy : 'fecha_ultima_actualizacion';

        $stmt = $this->pdo->prepare("
            SELECT * FROM contenido
            ORDER BY $orderBy DESC
            LIMIT :limit
        ");

        $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll();
    }

    /**
     * Calcula y actualiza el rating ponderado de una película
     * Combina rating de TMDb (70%) + rating de usuarios (30%)
     */
    public function updateWeightedRating($movieId) {
        try {
            // Obtener rating original de TMDb
            $stmt = $this->pdo->prepare("
                SELECT calificacion_promedio as tmdb_rating
                FROM contenido
                WHERE id_contenido = :movie_id
            ");
            $stmt->execute([':movie_id' => $movieId]);
            $movie = $stmt->fetch();

            if (!$movie) {
                return false;
            }

            $tmdbRating = $movie['tmdb_rating'];

            // Obtener rating promedio de usuarios
            $stmt = $this->pdo->prepare("
                SELECT AVG(puntuacion) as user_avg, COUNT(*) as user_count
                FROM calificaciones
                WHERE id_contenido = :movie_id
            ");
            $stmt->execute([':movie_id' => $movieId]);
            $userData = $stmt->fetch();

            $userRating = $userData['user_avg'] ?? null;
            $userCount = $userData['user_count'] ?? 0;

            // Calcular rating ponderado
            $finalRating = $this->calculateWeightedRating($tmdbRating, $userRating, $userCount);

            // Actualizar el rating en la base de datos
            $stmt = $this->pdo->prepare("
                UPDATE contenido
                SET calificacion_promedio = :final_rating
                WHERE id_contenido = :movie_id
            ");

            $stmt->execute([
                ':final_rating' => $finalRating,
                ':movie_id' => $movieId
            ]);

            return $finalRating;

        } catch (Exception $e) {
            error_log("Error updating weighted rating for movie {$movieId}: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Calcula el rating ponderado: TMDb (70%) + Usuarios (30%)
     */
    private function calculateWeightedRating($tmdbRating, $userRating, $userCount) {
        // Si no hay reseñas de usuarios, usar solo TMDb
        if ($userRating === null || $userCount === 0) {
            return $tmdbRating;
        }

        // Si hay pocas reseñas de usuarios (< 3), dar más peso a TMDb
        $weightTmdb = ($userCount < 3) ? 0.85 : 0.70;
        $weightUsers = 1 - $weightTmdb;

        return round(($tmdbRating * $weightTmdb) + ($userRating * $weightUsers), 1);
    }

    /**
     * Obtiene el rating original de TMDb para una película específica
     */
    public function getMovieRatingFromTMDb($tmdbId) {
        $endpoint = "/movie/{$tmdbId}";
        $data = $this->makeRequest($endpoint);

        if ($data && isset($data['vote_average'])) {
            return (float) $data['vote_average'];
        }

        return null;
    }

    /**
     * Obtiene películas trending directamente de TMDb sin guardar en DB
     * Para mostrar en la página principal cuando la DB está vacía
     */
    public function getTrendingMoviesDirect($limit = 8) {
        $endpoint = "/trending/movie/week";
        $data = $this->makeRequest($endpoint);

        if (!$data || !isset($data['results'])) {
            return [];
        }

        $movies = array_slice($data['results'], 0, $limit);
        return $this->processMoviesForDisplay($movies);
    }

    /**
     * Procesa películas para mostrar directamente (sin guardar en DB)
     */
    private function processMoviesForDisplay($movies) {
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

            $processedMovies[] = [
                'id_contenido' => $tmdbId, // Usamos tmdb_id como identificador temporal
                'titulo' => $titulo,
                'tipo' => 'pelicula',
                'descripcion' => $descripcion,
                'poster_url' => $poster,
                'trailer_url' => $trailer,
                'calificacion_promedio' => $rating,
                'fecha_lanzamiento' => isset($movie['release_date']) ? $movie['release_date'] : null,
                'edad_badge' => $this->getEdadBadge($rating)
            ];
        }

        return $processedMovies;
    }

    /**
     * Procesa películas optimizadas (sin detalles adicionales ni trailers)
     * Para mejorar el rendimiento en la página principal
     */
    private function processMoviesOptimized($movies) {
        $processedMovies = [];

        foreach ($movies as $movie) {
            $tmdbId = $movie['id'];
            $titulo = $movie['title'] ?? $movie['name'] ?? 'Título desconocido';
            $poster = isset($movie['poster_path']) ? $this->imageBaseUrl . $movie['poster_path'] : null;
            $rating = $movie['vote_average'] ?? null;

            // Usar descripción básica del overview si está disponible
            $descripcion = $movie['overview'] ?? 'Sin descripción disponible';

            // Determinar tipo (película o serie)
            $tipo = isset($movie['media_type']) ? $movie['media_type'] : 'pelicula';
            if ($tipo === 'tv') {
                $tipo = 'serie';
            }

            // Guardar en base de datos sin detalles adicionales
            $this->saveMovie([
                'tmdb_id' => $tmdbId,
                'titulo' => $titulo,
                'tipo' => $tipo,
                'descripcion' => $descripcion,
                'poster_url' => $poster,
                'trailer_url' => null, // Sin trailer para optimización
                'calificacion_promedio' => $rating,
                'fecha_lanzamiento' => isset($movie['release_date']) ? $movie['release_date'] : null,
                'idioma_original' => $movie['original_language'] ?? null
            ]);

            $processedMovies[] = [
                'id_contenido' => $tmdbId,
                'titulo' => $titulo,
                'tipo' => $tipo,
                'descripcion' => $descripcion,
                'poster_url' => $poster,
                'trailer_url' => null,
                'calificacion_promedio' => $rating,
                'fecha_lanzamiento' => isset($movie['release_date']) ? $movie['release_date'] : null,
                'edad_badge' => $this->getEdadBadge($rating)
            ];
        }

        return $processedMovies;
    }

    private function getEdadBadge($rating) {
        if ($rating === null) return '+13';
        $p = $rating * 10;
        if ($p >= 85) return '+16';
        if ($p >= 70) return '+13';
        if ($p >= 50) return '+8';
        return 'ATP';
    }
}
