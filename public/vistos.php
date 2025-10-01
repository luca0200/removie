<?php
require __DIR__ . '/config.php';
$title = 'Películas Vistas';
include __DIR__ . '/header.php';
?>
<section class="section">
  <h2>Películas Vistas</h2>
  <p>Películas que has marcado como vistas.</p>
  <div id="watched-cards" class="cards"></div>
</section>
<?php include __DIR__ . '/footer.php'; ?>
