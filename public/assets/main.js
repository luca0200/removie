(function(){
  // CSRF token handling
  function getCsrfToken() {
    const metaToken = document.querySelector('meta[name="csrf-token"]');
    if (metaToken && metaToken.getAttribute('content')) {
      return metaToken.getAttribute('content');
    }
    return getCookie('csrf_token') || '';
  }

  function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
  }

  // Generic toggle function for favorites, watched, pending
  async function toggleAction(endpoint, movieId, buttonSelector) {
    try {
      const csrfToken = getCsrfToken();
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `movie_id=${movieId}&csrf_token=${encodeURIComponent(csrfToken)}`
      });

      const result = await response.json();
      if (result.success) {
        const btn = document.querySelector(`${buttonSelector}[data-movie-id="${movieId}"]`);
        if (btn) {
          const isAdded = result.action === 'added';
          btn.classList.toggle('active', isAdded);
          btn.setAttribute(`data-is-${buttonSelector.includes('favorite') ? 'favorite' : buttonSelector.includes('watched') ? 'watched' : 'pending'}`, isAdded ? 'true' : 'false');
          
          // Update button text based on type
          if (buttonSelector.includes('favorite')) {
            btn.innerHTML = isAdded ? '★ En favoritos' : '☆ Agregar a favoritos';
          } else if (buttonSelector.includes('watched')) {
            btn.innerHTML = isAdded ? '✓ Visto' : '○ Marcar como visto';
          } else if (buttonSelector.includes('pending')) {
            btn.innerHTML = isAdded ? '⏰ En pendientes' : '⏱ Agregar a pendientes';
          }
        }
        console.log(`${buttonSelector} actualizado:`, result.message);
      } else {
        console.error(`Error toggling ${buttonSelector}:`, result.message);
        alert('Error: ' + result.message);
      }
    } catch (error) {
      console.error(`Error toggling ${buttonSelector}:`, error);
      alert('Error de conexión');
    }
  }

  // Event delegation for all buttons
  document.addEventListener('click', (e) => {
    const favoriteBtn = e.target.closest('.favorite-btn');
    if (favoriteBtn) {
      e.preventDefault();
      const movieId = parseInt(favoriteBtn.dataset.movieId);
      toggleAction('toggle_favorite.php', movieId, '.favorite-btn');
    }

    const watchedBtn = e.target.closest('.watched-btn');
    if (watchedBtn) {
      e.preventDefault();
      const movieId = parseInt(watchedBtn.dataset.movieId);
      toggleAction('toggle_visto.php', movieId, '.watched-btn');
    }

    const pendingBtn = e.target.closest('.pending-btn');
    if (pendingBtn) {
      e.preventDefault();
      const movieId = parseInt(pendingBtn.dataset.movieId);
      toggleAction('toggle_pendiente.php', movieId, '.pending-btn');
    }
  });

  // Favorites loading for favorites page
  const favContainer = document.getElementById('fav-cards');
  if (favContainer) {
    fetch('get_favorites.php')
      .then(r => r.json())
      .then(favorites => {
        if (favorites.length === 0) {
          favContainer.innerHTML = '<p>No tenés favoritos todavía.</p>';
          return;
        }

        Promise.all(favorites.map(id => fetch('partial_card.php?id=' + id).then(r => r.text()).catch(() => '')))
          .then(htmls => {
            favContainer.innerHTML = htmls.join('');
          });
      })
      .catch(() => {
        favContainer.innerHTML = '<p>Error cargando favoritos.</p>';
      });
  }

  // Watched movies loading for vistos page
  const watchedContainer = document.getElementById('watched-cards');
  if (watchedContainer) {
    fetch('get_vistos.php')
      .then(r => r.json())
      .then(watched => {
        if (watched.length === 0) {
          watchedContainer.innerHTML = '<p>No tenés películas vistas todavía.</p>';
          return;
        }

        Promise.all(watched.map(id => fetch('partial_card.php?id=' + id).then(r => r.text()).catch(() => '')))
          .then(htmls => {
            watchedContainer.innerHTML = htmls.join('');
          });
      })
      .catch(() => {
        watchedContainer.innerHTML = '<p>Error cargando películas vistas.</p>';
      });
  }

  // Pending movies loading for pendientes page
  const pendingContainer = document.getElementById('pending-cards');
  if (pendingContainer) {
    fetch('get_pendientes.php')
      .then(r => r.json())
      .then(pending => {
        if (pending.length === 0) {
          pendingContainer.innerHTML = '<p>No tenés películas pendientes todavía.</p>';
          return;
        }

        Promise.all(pending.map(id => fetch('partial_card.php?id=' + id).then(r => r.text()).catch(() => '')))
          .then(htmls => {
            pendingContainer.innerHTML = htmls.join('');
          });
      })
      .catch(() => {
        pendingContainer.innerHTML = '<p>Error cargando películas pendientes.</p>';
      });
  }

  // Sync button states on page load
  async function syncButtonStates() {
    console.log('Sincronizando estados de botones...');

    // Only sync if user is logged in
    if (!getCsrfToken()) {
      console.log('Usuario no logueado, omitiendo sincronización');
      return;
    }

    try {
      const response = await fetch('get_user_states.php');
      const states = await response.json();

      console.log('Estados obtenidos del servidor:', states);

      // Update favorite buttons
      document.querySelectorAll('.favorite-btn[data-movie-id]').forEach(btn => {
        const movieId = parseInt(btn.dataset.movieId);
        const isFavorite = states.favorites.includes(movieId);

        btn.classList.toggle('active', isFavorite);
        btn.setAttribute('data-is-favorite', isFavorite ? 'true' : 'false');
        btn.innerHTML = isFavorite ? '★ En favoritos' : '☆ Agregar a favoritos';

        console.log(`Botón favorito ${movieId}: ${isFavorite ? 'activo' : 'inactivo'}`);
      });

      // Update watched buttons
      document.querySelectorAll('.watched-btn[data-movie-id]').forEach(btn => {
        const movieId = parseInt(btn.dataset.movieId);
        const isWatched = states.watched.includes(movieId);

        btn.classList.toggle('active', isWatched);
        btn.setAttribute('data-is-watched', isWatched ? 'true' : 'false');
        btn.innerHTML = isWatched ? '✓ Visto' : '○ Marcar como visto';

        console.log(`Botón visto ${movieId}: ${isWatched ? 'activo' : 'inactivo'}`);
      });

      // Update pending buttons
      document.querySelectorAll('.pending-btn[data-movie-id]').forEach(btn => {
        const movieId = parseInt(btn.dataset.movieId);
        const isPending = states.pending.includes(movieId);

        btn.classList.toggle('active', isPending);
        btn.setAttribute('data-is-pending', isPending ? 'true' : 'false');
        btn.innerHTML = isPending ? '⏰ En pendientes' : '⏱ Agregar a pendientes';

        console.log(`Botón pendiente ${movieId}: ${isPending ? 'activo' : 'inactivo'}`);
      });

      console.log('✅ Sincronización completada');

    } catch (error) {
      console.error('Error sincronizando estados:', error);
    }
  }

  // Initialize on DOM load
  document.addEventListener('DOMContentLoaded', function() {
    syncButtonStates();
  });
})();
