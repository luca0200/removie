<?php
require_once 'config.php';
safe_session_start();

// Generar token CSRF si no existe
if (!isset($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

// Establecer cookie CSRF para JavaScript
setcookie('csrf_token', $_SESSION['csrf_token'], [
    'expires' => time() + 3600, // 1 hora
    'path' => '/',
    'secure' => false, // Cambiar a true en producción con HTTPS
    'httponly' => false, // Necesario para que JavaScript pueda leerlo
    'samesite' => 'Strict'
]);

$title = $title ?? 'Re-movie';
$isLoggedIn = isset($_SESSION['user_id']);
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><?= htmlspecialchars($title) ?></title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="assets/styles.css">
  <meta name="csrf-token" content="<?= $_SESSION['csrf_token'] ?? '' ?>">
</head>
<body>
<header class="topbar">
  <a class="brand" href="index.php">Re-movie</a>
  <form class="search" action="search.php" method="get">
    <input name="q" type="search" placeholder="¿Qué querés ver?" value="<?= isset($_GET['q']) ? htmlspecialchars($_GET['q']) : '' ?>">
    <button type="submit">BUSCAR</button>
  </form>
  <nav class="nav">
    <?php if ($isLoggedIn): ?>
      <a href="perfil.php" class="user-profile-link">Mi Perfil</a>
      <span class="user-greeting">Hola, <?= htmlspecialchars($_SESSION['email']) ?></span>
      <a href="logout.php" class="btn-secondary">Cerrar sesión</a>
    <?php else: ?>
      <a href="login.php" class="btn-secondary">Iniciar sesión</a>
    <?php endif; ?>
  </nav>
</header>
<main class="container">
