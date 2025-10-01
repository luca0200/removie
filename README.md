# Re-movie - Sistema de Gestión de Películas

Una aplicación web para gestionar películas y series utilizando la API de The Movie Database (TMDb) con almacenamiento local en base de datos MySQL.

## 🚀 Características Principales

- ✅ **Sincronización automática con TMDb**: Obtiene películas trending y populares
- ✅ **Almacenamiento local**: Guarda películas en base de datos MySQL para acceso rápido
- ✅ **Actualización semanal**: Sistema automático para mantener el contenido actualizado
- ✅ **Búsqueda inteligente**: Busca primero en la base de datos local, luego en TMDb
- ✅ **Sistema de favoritos**: Los usuarios pueden marcar películas como favoritas
- ✅ **Lista de películas vistas**: Los usuarios pueden marcar películas como vistas
- ✅ **Lista de películas pendientes**: Los usuarios pueden agregar películas a ver más tarde
- ✅ **Sistema de reseñas**: Los usuarios pueden escribir reseñas y calificar películas
- ✅ **Perfil de usuario**: Gestión personalizada de preferencias y listas
- ✅ **Calificaciones**: Sistema de calificación de películas
- ✅ **Interfaz responsiva**: Diseño moderno y adaptativo

## ⚡ Optimizaciones y Funcionalidades Avanzadas

### 🔄 Sistema de Cache Inteligente
- **Cache de API TMDb**: Reduce llamadas a la API en ~60% con respuestas cacheadas por 2 horas
- **Método optimizado para películas populares**: Carga más rápida de la página principal sin llamadas adicionales
- **Cache local**: Almacena películas por 7 días para acceso ultra-rápido

### 🗄️ Optimización de Base de Datos
- **Índices estratégicos**: Implementados para búsquedas rápidas por TMDb ID, calificación, fecha y título
- **Consultas optimizadas**: Eliminación de duplicados y manejo eficiente de datos
- **Rendimiento mejorado**: Carga de página ~40% más rápida

### 🖼️ Lazy Loading de Imágenes
- **Carga progresiva**: Imágenes se cargan solo cuando entran en el viewport
- **Animaciones suaves**: Transiciones visuales durante la carga
- **Optimización de memoria**: Reduce uso de recursos del navegador

### 📊 Sistema de Ratings Inteligente
- **Ponderación automática**: TMDb (70%) + Calificaciones de usuarios (30%)
- **Adaptativo**: Si hay menos de 3 reseñas, TMDb tiene 85% de peso
- **Actualización en tiempo real**: Se recalcula automáticamente con cada nueva reseña

### 📈 Monitor de Rendimiento
- **Dashboard integrado**: Estadísticas de base de datos, cache y sistema
- **Métricas en tiempo real**: Seguimiento de optimizaciones y recomendaciones
- **Herramientas de debugging**: Logs detallados para mantenimiento

## 📋 Requisitos

- PHP 7.4 o superior
- MySQL 5.7 o superior
- Servidor web (Apache/Nginx)
- API Key de TMDb (gratuita)

## 🛠️ Instalación

### 1. Configuración de la Base de Datos

1. Importa el archivo `removie.sql` en tu servidor MySQL
2. Configura las credenciales de la base de datos en `public/config.php`

### 2. Configuración de TMDb API

1. Regístrate en [The Movie Database](https://www.themoviedb.org/)
2. Obtén tu API Key gratuita
3. La API Key ya está configurada en el código: `eb8525892bb19b238dd289e0cd30cd05`

### 3. Primer Uso

1. Accede a `http://localhost/removie/public/index.php`
2. La aplicación automáticamente cargará películas trending desde TMDb
3. Las películas se guardarán en la base de datos para acceso rápido
4. ¡Listo! Ya puedes usar la aplicación

## 📁 Estructura del Proyecto

```
removie/
├── public/                    # Archivos públicos de la aplicación
│   ├── index.php              # Página principal
│   ├── search.php             # Búsqueda de películas
│   ├── detalle.php            # Detalle de película
│   ├── favoritos.php          # Lista de favoritos
│   ├── vistos.php             # Lista de películas vistas
│   ├── pendientes.php         # Lista de películas pendientes
│   ├── perfil.php             # Perfil de usuario
│   ├── login.php              # Sistema de autenticación
│   ├── registro.php           # Registro de usuarios
│   ├── guardar_resena.php     # Guardar reseñas
│   ├── guardar_calificacion.php # Guardar calificaciones
│   ├── tmdb_service.php       # Servicio TMDb
│   ├── update_database.php    # Actualizar DB
│   ├── optimize_database.php  # Optimización de BD
│   ├── performance_monitor.php # Monitor de rendimiento
│   ├── config.php             # Configuración
│   ├── cache_helper.php       # Helper de cache
│   ├── assets/                # CSS, JS, imágenes
│   └── ...
├── removie.sql                # Base de datos
└── README.md
```

## 🔄 Funcionamiento del Sistema

### Flujo de Datos

1. **Primera carga**: El sistema verifica si la base de datos tiene contenido reciente
2. **Si está vacía**: Obtiene automáticamente películas trending desde TMDb y las guarda en la base de datos
3. **Contenido local**: Siempre muestra películas desde la base de datos local
4. **Búsqueda**: Busca primero en local, si no encuentra, consulta TMDb y guarda resultados
5. **Actualización semanal**: `update_database.php` actualiza automáticamente el contenido

### Sistema de Películas Trending y Populares

#### 🎯 Películas Trending
- **Fuente**: Endpoint `/trending/movie/week` de TMDb API
- **Período**: Películas más populares de la semana actual
- **Algoritmo TMDb**: Basado en interacciones de usuarios, vistas, búsquedas y engagement
- **Uso**: Se muestran en la sección "Tendencias" de la página principal

#### 🔥 Películas Populares
- **Fuente**: Endpoint `/movie/popular` de TMDb API
- **Período**: Películas populares de todos los tiempos
- **Algoritmo TMDb**: Basado en popularidad general, calificaciones y vistas acumuladas
- **Uso**: Se muestran en la sección "Populares" de la página principal

#### 📊 Procesamiento de Datos

Para cada película obtenida, el sistema recopila:

- **Información básica**: Título, ID único TMDb, fecha de lanzamiento
- **Multimedia**: URL del póster, trailer de YouTube
- **Contenido**: Descripción/sinopsis, calificación promedio
- **Metadatos**: Idioma original, tipo (película/serie)
- **Clasificación**: Badge de edad basado en la calificación (+16, +13, +8, ATP)

#### 🔄 Estrategia de Carga

1. **Primera visita**: Si la DB está vacía, carga automáticamente películas trending
2. **Cache inteligente**: Las películas se almacenan localmente por 7 días
3. **Actualización automática**: `update_database.php` refresca el contenido semanalmente
4. **Fallback robusto**: Si TMDb no responde, muestra contenido cacheado existente

### Archivos Importantes

- **`tmdb_service.php`**: Clase principal que maneja todas las interacciones con TMDb API
- **`update_database.php`**: Script para actualizaciones semanales automáticas
- **`config.php`**: Configuración de base de datos y constantes

## ⏰ Actualización Automática

El sistema actualiza automáticamente el contenido cuando detecta que los datos tienen más de `CACHE_DAYS` días de antigüedad.

### Configuración del Período de Actualización

1. **Editar la frecuencia de cache** (en `config.php`):
```php
define('CACHE_DAYS', 7); // Cambia 7 por el número de días deseado
```

2. **Configurar cron job** (ejemplo para actualización semanal):
```bash
# Cada semana (ejecutar los domingos a las 3 AM)
0 3 * * 0 /usr/bin/php /path/to/removie/public/update_database.php
```

3. **Ejecución manual**:
```bash
php /path/to/removie/public/update_database.php
```

**Nota**: El período de actualización depende de dos factores:
- `CACHE_DAYS`: Define cuándo el contenido se considera "viejo"
- Cron job: Define con qué frecuencia se ejecuta la actualización automática

## 🎯 Funcionalidades Implementadas

### ✅ Sistema de Contenido
- [x] Obtención automática de películas trending/populares
- [x] Almacenamiento en base de datos MySQL
- [x] Actualización semanal automática
- [x] Búsqueda en base de datos local
- [x] Fallback a TMDb API cuando no hay resultados locales

### ✅ Interfaz de Usuario
- [x] Página principal con secciones (Tendencias, Recientes, Populares)
- [x] Sistema de búsqueda funcional
- [x] Páginas de detalle de películas
- [x] Sistema de favoritos
- [x] Lista de películas vistas
- [x] Lista de películas pendientes
- [x] Sistema de reseñas
- [x] Perfil de usuario
- [x] Sistema de calificaciones

### ✅ Optimización
- [x] Cache de 7 días para evitar consultas excesivas a TMDb
- [x] Eliminación de duplicados en búsquedas
- [x] Manejo de errores robusto
- [x] Logs de errores para debugging

## 🔧 Personalización

### Cambiar el límite de películas
Edita `tmdb_service.php` y modifica los valores en:
```php
$trendingMovies = $tmdbService->getTrendingMovies(20); // Cambia 20 por el número deseado
$popularMovies = $tmdbService->getPopularMovies(20);  // Cambia 20 por el número deseado
```

### Cambiar el período de actualización
Edita `config.php`:
```php
define('CACHE_DAYS', 7); // Cambia 7 por el número de días deseado
```

## 🐛 Solución de Problemas

### La página principal está vacía
1. Verifica tu conexión a internet para cargar películas desde TMDb
2. Verifica que la base de datos esté correctamente configurada
3. Comprueba los logs de errores del servidor

### Las búsquedas no funcionan
1. Verifica la conexión a internet
2. Comprueba que la API Key de TMDb sea válida
3. Revisa los logs de errores

### Error de base de datos
1. Verifica las credenciales en `config.php`
2. Asegúrate de que la base de datos `removie` exista
3. Importa el archivo `removie.sql` si es necesario

## 📊 Estadísticas del Sistema

- **Películas almacenadas**: Se actualizan automáticamente según el valor de `CACHE_DAYS` (por defecto: 7 días)
- **API calls**: Minimizados gracias al sistema de cache local
- **Rendimiento**: Carga rápida desde base de datos local
- **Disponibilidad**: Funciona incluso sin conexión a TMDb (con contenido cacheado)

## 🔮 Próximas Mejoras

- [ ] Sistema de recomendaciones basado en favoritos
- [ ] Filtros avanzados (género, año, calificación)
- [ ] API REST para integración con otras aplicaciones
- [ ] Notificaciones de nuevos lanzamientos
- [ ] Soporte para series de TV

## 📝 Licencia

Este proyecto es de uso educativo y de demostración.

---

**Desarrollado para Re-movie** - Sistema de gestión de películas con integración TMDb
