const API_KEY = '9d8e505f22d8a8ad9e37d7ca2ffad2ed';
const BASE_URL = 'https://api.themoviedb.org/3';
const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';

let ratedMovies = JSON.parse(localStorage.getItem('ratedMovies')) || {};

const loader = document.getElementById('loader');
const errorMessage = document.getElementById('errorMessage');
const movieGrid = document.getElementById('movieGrid');

const setLoading = (state) => {
  loader.style.display = state ? 'block' : 'none';
};

const setError = (message) => {
  errorMessage.style.display = message ? 'block' : 'none';
  errorMessage.textContent = message || '';
};

const renderMovies = (movies) => {
  movieGrid.innerHTML = '';
  if (movies.length === 0) {
    movieGrid.innerHTML = '<p class="no-results">No movies found matching your criteria.</p>';
    return;
  }

  movies.forEach(movie => {
    const vote = movie.vote_average?.toFixed(1) || 'N/A';
    const year = movie.release_date ? movie.release_date.substring(0, 4) : 'N/A';
    const rating = ratedMovies[movie.id] || 0;

    const options = ['<option value="0">Rate this</option>'];
    for (let i = 1; i <= 5; i++) {
      options.push(`<option value="${i}" ${rating == i ? 'selected' : ''}>${i} ${'★'.repeat(i)}</option>`);
    }

    const poster = movie.poster_path 
      ? `${IMAGE_BASE_URL}${movie.poster_path}`
      : 'https://via.placeholder.com/300x450?text=No+Poster';

    const movieElement = document.createElement('div');
    movieElement.className = 'movie-card';
    movieElement.innerHTML = `
      <img src="${poster}" class="movie-poster" alt="${movie.title}" onerror="this.src='https://via.placeholder.com/300x450?text=No+Poster';">
      <div class="movie-details">
        <h3 class="movie-title">${movie.title}</h3>
        <div class="movie-info">
          <div class="movie-rating">
            <span class="star-icon">★</span> ${vote}
          </div>
          <div class="movie-year">${year}</div>
        </div>
        <select class="rating-select" data-movie-id="${movie.id}">
          ${options.join('')}
        </select>
      </div>
    `;
    movieGrid.appendChild(movieElement);
  });

  document.querySelectorAll('.rating-select').forEach(select => {
    select.addEventListener('change', (e) => {
      const movieId = e.target.dataset.movieId;
      const rating = parseInt(e.target.value);
      ratedMovies[movieId] = rating;
      localStorage.setItem('ratedMovies', JSON.stringify(ratedMovies));
    });
  });
};


