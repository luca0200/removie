<?php
require __DIR__ . '/config.php';
$title = 'Pendientes por Ver';
include __DIR__ . '/header.php';
?>
<section class="section">
  <h2>Pendientes por Ver</h2>
  <p>Películas que quieres ver más tarde.</p>
  <div id="pending-cards" class="cards"></div>
</section>
<?php include __DIR__ . '/footer.php'; ?>
