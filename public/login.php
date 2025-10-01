<?php
require __DIR__ . '/config.php';

$title = 'Iniciar sesión';
$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    if (empty($email) || empty($password)) {
        $error = 'Por favor completa todos los campos.';
    } else {
        try {
            $pdo = db();
            $stmt = $pdo->prepare("SELECT id_usuario, email, password_hash FROM usuarios WHERE email = :email");
            $stmt->execute([':email' => $email]);
            $user = $stmt->fetch();

            if ($user && password_verify($password, $user['password_hash'])) {
                // Iniciar sesión
                safe_session_start();
                $_SESSION['user_id'] = $user['id_usuario'];
                $_SESSION['email'] = $user['email'];

                $success = '¡Bienvenido! Redirigiendo...';
                header("refresh:2;url=index.php");
            } else {
                $error = 'Email o contraseña incorrectos.';
            }
        } catch (Exception $e) {
            $error = 'Error del sistema. Intenta nuevamente.';
        }
    }
}

include __DIR__ . '/header.php';
?>

<section class="section">
  <div class="login-container">
    <div class="login-form">
      <h2>Iniciar sesión</h2>

      <?php if ($error): ?>
        <div class="alert error"><?= htmlspecialchars($error) ?></div>
      <?php endif; ?>

      <?php if ($success): ?>
        <div class="alert success"><?= htmlspecialchars($success) ?></div>
      <?php endif; ?>

      <form method="post" action="">
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" id="email" name="email" required
                 value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
        </div>

        <div class="form-group">
          <label for="password">Contraseña:</label>
          <input type="password" id="password" name="password" required>
        </div>

        <button type="submit" class="btn">Iniciar sesión</button>
      </form>

      <div class="login-links">
        <a href="registro.php">¿No tenés cuenta? Registrate</a>
      </div>
    </div>
  </div>
</section>

<?php include __DIR__ . '/footer.php'; ?>
