<?php
/**
 * Cache Helper para optimizar las llamadas a la API de TMDb
 */

class CacheHelper {
    private $cacheDir;
    private $cacheTime = 7200; // 2 horas por defecto (más conservador)

    public function __construct($cacheDir = null) {
        $this->cacheDir = $cacheDir ?: __DIR__ . '/cache';
        if (!is_dir($this->cacheDir)) {
            mkdir($this->cacheDir, 0755, true);
        }
    }

    /**
     * Obtiene datos del cache o los guarda si no existen
     */
    public function getOrSet($key, $callback, $cacheTime = null) {
        $cacheFile = $this->getCacheFile($key);
        $cacheTime = $cacheTime ?: $this->cacheTime;

        // Verificar si el cache existe y es válido
        if (file_exists($cacheFile) && (time() - filemtime($cacheFile)) < $cacheTime) {
            return json_decode(file_get_contents($cacheFile), true);
        }

        // Obtener datos frescos
        $data = $callback();

        // Guardar en cache
        if ($data !== null) {
            file_put_contents($cacheFile, json_encode($data));
        }

        return $data;
    }

    /**
     * Limpia el cache
     */
    public function clear($key = null) {
        if ($key) {
            $cacheFile = $this->getCacheFile($key);
            if (file_exists($cacheFile)) {
                unlink($cacheFile);
            }
        } else {
            // Limpiar todo el cache
            $files = glob($this->cacheDir . '/*');
            foreach ($files as $file) {
                if (is_file($file)) {
                    unlink($file);
                }
            }
        }
    }

    /**
     * Obtiene la ruta del archivo de cache
     */
    private function getCacheFile($key) {
        return $this->cacheDir . '/' . md5($key) . '.json';
    }
}
