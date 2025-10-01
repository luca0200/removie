<?php
require __DIR__ . '/config.php';

$title = 'Registrarse';
$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';

    if (empty($email) || empty($password) || empty($confirm_password)) {
        $error = 'Por favor completa todos los campos.';
    } elseif ($password !== $confirm_password) {
        $error = 'Las contraseñas no coinciden.';
    } elseif (strlen($password) < 6) {
        $error = 'La contraseña debe tener al menos 6 caracteres.';
    } else {
        try {
            $pdo = db();

            // Verificar si el email ya existe
            $stmt = $pdo->prepare("SELECT id_usuario FROM usuarios WHERE email = :email");
            $stmt->execute([':email' => $email]);

            if ($stmt->fetch()) {
                $error = 'Este email ya está registrado.';
            } else {
                // Crear nuevo usuario
                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("INSERT INTO usuarios (email, password_hash, fecha_registro) VALUES (:email, :password_hash, NOW())");
                $stmt->execute([
                    ':email' => $email,
                    ':password_hash' => $password_hash
                ]);

                $success = '¡Registro exitoso! Ya podés iniciar sesión.';
                header("refresh:2;url=login.php");
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
      <h2>Crear cuenta</h2>

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
          <input type="password" id="password" name="password" required
                 minlength="6" placeholder="Mínimo 6 caracteres">
        </div>

        <div class="form-group">
          <label for="confirm_password">Confirmar contraseña:</label>
          <input type="password" id="confirm_password" name="confirm_password" required>
        </div>

        <button type="submit" class="btn">Registrarse</button>
      </form>

      <div class="login-links">
        <a href="login.php">¿Ya tenés cuenta? Iniciá sesión</a>
      </div>
    </div>
  </div>
</section>

<?php include __DIR__ . '/footer.php'; ?>
