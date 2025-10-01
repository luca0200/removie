<?php
require __DIR__ . '/config.php';
$id = (int)($_GET['id'] ?? 0);
$pdo = db();
$stmt = $pdo->prepare("SELECT * FROM contenido WHERE id_contenido = :id");
$stmt->execute([':id' => $id]);
$c = $stmt->fetch();
if (!$c) {
    http_response_code(404);
    exit;
}
echo render_movie_card($c, false);
?>
