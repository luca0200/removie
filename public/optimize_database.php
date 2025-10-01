<?php
/**
 * Script de optimización de base de datos
 * Agrega índices para mejorar el rendimiento de las consultas
 */

require __DIR__ . '/config.php';

try {
    $pdo = db();

    echo "Optimizando base de datos...\n";

    // Índice para tmdb_id (búsqueda rápida por ID de TMDb)
    $pdo->exec("CREATE INDEX IF NOT EXISTS idx_contenido_tmdb_id ON contenido(tmdb_id)");

    // Índice para calificacion_promedio (ordenamiento por rating)
    $pdo->exec("CREATE INDEX IF NOT EXISTS idx_contenido_calificacion ON contenido(calificacion_promedio DESC)");

    // Índice para fecha_ultima_actualizacion (ordenamiento por fecha)
    $pdo->exec("CREATE INDEX IF NOT EXISTS idx_contenido_fecha ON contenido(fecha_ultima_actualizacion DESC)");

    // Índice compuesto para búsquedas comunes
    $pdo->exec("CREATE INDEX IF NOT EXISTS idx_contenido_tipo_fecha ON contenido(tipo, fecha_ultima_actualizacion DESC)");

    // Índice para búsquedas por título
    $pdo->exec("CREATE INDEX IF NOT EXISTS idx_contenido_titulo ON contenido(titulo)");

    echo "✅ Índices creados exitosamente!\n";
    echo "La base de datos ahora debería ser más rápida.\n";

} catch (Exception $e) {
    echo "❌ Error al optimizar la base de datos: " . $e->getMessage() . "\n";
}
