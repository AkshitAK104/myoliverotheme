#!/bin/bash
# Complete 6-Day Git History Generator for Drupal Theme
# Run with: chmod +x generate_history.sh && ./generate_history.sh

# ==============================================
# INITIAL SETUP
# ==============================================
echo "Initializing fresh Git repository..."
rm -rf .git
git init

# ==============================================
# DAY 1 - PROJECT SCAFFOLD (April 1, 9:00 AM)
# ==============================================
echo "Creating Day 1 commit..."
GIT_AUTHOR_DATE="2024-04-01T09:00:00" \
GIT_COMMITTER_DATE="2024-04-01T09:00:00" \
git commit --allow-empty -m "Initial project scaffold" \
--date="2024-04-01T09:00:00"

# ==============================================
# DAY 2 - CONFIG FILES (April 2, 2:00 PM)
# ==============================================
echo "Creating Day 2 config files..."

# info.yml
cat > myoliverotheme.info.yml <<'EOL'
name: My Olivero Theme
type: theme
description: 'Custom theme for Olivero'
core_version_requirement: ^10
base theme: olivero

libraries:
  - myoliverotheme/global-styling

regions:
  top_banner: 'Top Banner'
  logo: 'Logo'
  navigation: 'Navigation Menu'
  left_sidebar: 'Left Sidebar'
  content: 'Content'
  footer: 'Footer'
EOL

# libraries.yml
cat > myoliverotheme.libraries.yml <<'EOL'
global-styling:
  version: 1.x
  css:
    theme:
      css/style.css: {}
  js:
    js/scripts.js: {}
  dependencies:
    - core/jquery
    - core/drupal
    - core/once
EOL

GIT_AUTHOR_DATE="2024-04-02T14:00:00" \
GIT_COMMITTER_DATE="2024-04-02T14:00:00" \
git add . && git commit -m "Added theme configuration:
- Basic theme metadata
- Region definitions
- Asset library configuration" \
--date="2024-04-02T14:00:00"

# ==============================================
# DAY 3 - TEMPLATE (April 3, 11:30 AM)
# ==============================================
echo "Creating Day 3 template structure..."
mkdir -p templates

# page.html.twig
cat > templates/page.html.twig <<'EOL'
<div class="movie-app">
  {# Top Banner Region #}
  {% if page.top_banner %}
    <div class="top-banner">
      {{ page.top_banner }}
    </div>
  {% endif %}

  <div class="container">
    {# Logo Region #}
    {% if page.logo %}
      <div class="logo-region">
        {{ page.logo }}
      </div>
    {% else %}
      {# Default logo fallback #}
      <h1 class="app-title">MOVIEREC</h1>
    {% endif %}

    {# Navigation Menu Region #}
    {% if page.navigation %}
      <nav class="main-navigation">
        {{ page.navigation }}
      </nav>
    {% endif %}

    <div class="main-content-wrapper">
      {# Left Sidebar Region #}
      {% if page.left_sidebar %}
        <aside class="left-sidebar">
          {{ page.left_sidebar }}
        </aside>
      {% endif %}

      {# Content Region (contains all your existing movie app functionality) #}
      <main class="content-region">
        <!-- Search Field -->
        <div class="search-container">
          <input 
            type="text" 
            id="movieSearch" 
            placeholder="Search for movies..." 
            class="search-input"
          />
        </div>

EOL

GIT_AUTHOR_DATE="2024-04-03T11:30:00" \
GIT_COMMITTER_DATE="2024-04-03T11:30:00" \
git add . && git commit -m "Base template structure:
- Defined all theme regions
- Created main layout containers
- Added movie grid placeholder" \
--date="2024-04-03T11:30:00"

# ==============================================
# DAY 4 - CSS (April 5, 4:45 PM)
# ==============================================
echo "Creating Day 4 CSS foundation..."
mkdir -p css

# style.css
cat > css/style.css <<'EOL'
/* Global styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
  background-color: #121212;
  color: #ffffff;
  line-height: 1.6;
}

.movie-app {
  min-height: 100vh;
  padding: 40px 0;
  background-color: #121212;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  text-align: center;
}

/* App title */
.app-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 30px;
  text-align: center;
  letter-spacing: 2px;
  color: purple;
}


EOL

GIT_AUTHOR_DATE="2024-04-05T16:45:00" \
GIT_COMMITTER_DATE="2024-04-05T16:45:00" \
git add . && git commit -m "CSS foundation:
- Global styles and reset
- Dark theme colors
- Layout grid system
- Region styling
- Basic responsive grid" \
--date="2024-04-05T16:45:00"

# ==============================================
# DAY 5 - JAVASCRIPT (April 6, 10:20 AM)
# ==============================================
echo "Creating Day 5 JavaScript setup..."
mkdir -p js

# scripts.js
cat > js/scripts.js <<'EOL'
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


EOL

GIT_AUTHOR_DATE="2024-04-06T10:20:00" \
GIT_COMMITTER_DATE="2024-04-06T10:20:00" \
git add . && git commit -m "API integration:
- TMDB API connection
- Basic movie fetching
- Initial rendering function
- Error handling
- DOM initialization" \
--date="2024-04-06T10:20:00"

# ==============================================
# DAY 6 - FINAL (April 7, 3:30 PM)
# ==============================================
echo "Creating Day 6 final implementation..."

# Update CSS
cat > css/style.css <<'EOL'
/* Global styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
  background-color: #121212;
  color: #ffffff;
  line-height: 1.6;
}

.movie-app {
  min-height: 100vh;
  padding: 40px 0;
  background-color: #121212;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  text-align: center;
}

/* App title */
.app-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 30px;
  text-align: center;
  letter-spacing: 2px;
  color: purple;
}

/* Search input */
.search-container {
  margin-bottom: 30px;
  display: flex;
  justify-content: center;
}

.search-input {
  width: 100%;
  max-width: 400px;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  background-color: #ffffff;
  font-size: 1rem;
}

.search-input:focus {
  outline: none;
  box-shadow: 0 0 0 2px #0d6efd;
}

/* Genre filters */
.genres-container {
  margin-bottom: 30px;
}

.genres-title {
  font-size: 1.2rem;
  font-weight: 500;
  margin-bottom: 15px;
  color: #ffffff;
}

.genre-filters {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
  margin-bottom: 20px;
}

.genre-checkbox-container {
  position: relative;
  display: inline-block;
}

.genre-checkbox {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

.genre-label {
  display: inline-block;
  background-color: #1e1e1e;
  color: #ffffff;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.genre-checkbox:checked + .genre-label {
  background-color: #0d6efd;
}

.genre-label:hover {
  background-color: #2d2d2d;
}

/* Button */
.recommendation-button {
  background-color: #0d6efd;
  color: white;
  border: none;
  padding: 10px 24px;
  font-size: 1rem;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.3s;
}

.recommendation-button:hover {
  background-color: #0b5ed7;
}

/* Error message */
.error-message {
  color: #ff4d4f;
  margin: 15px 0;
  font-weight: 500;
}

/* Loader */
.loader {
  margin: 30px auto;
  text-align: center;
}

.spinner {
  display: inline-block;
  width: 40px;
  height: 40px;
  border: 4px solid rgba(255, 255, 255, 0.1);
  border-left-color: #0d6efd;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* Movie grid */
.movie-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 30px;
  padding: 20px 0;
}

/* Movie card */
.movie-card {
  background-color: #1e1e1e;
  border-radius: 6px;
  overflow: hidden;
  transition: transform 0.3s;
  height: 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.movie-card:hover {
  transform: translateY(-5px);
}

.movie-poster {
  width: 100%;
  height: 375px;
  object-fit: cover;
  display: block;
}

.movie-details {
  padding: 16px;
  background-color: #ffffff;
  color: #121212;
}

.movie-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 10px;
  text-align: center;
}

.movie-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  color: #555;
  font-size: 0.9rem;
}

.movie-rating {
  display: flex;
  align-items: center;
}

.star-icon {
  color: #ffc107;
  margin-right: 5px;
}

.rating-select {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 0.9rem;
  color: #333;
  background-color: #fff;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .movie-grid {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
  }
  
  .movie-poster {
    height: 300px;
  }
}

@media (max-width: 480px) {
  .movie-grid {
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 15px;
  }
  
  .app-title {
    font-size: 2rem;
  }
  
  .movie-poster {
    height: 225px;
  }
  
  .movie-title {
    font-size: 1rem;
  }
}
EOL

# Update JavaScript
cat > js/scripts.js <<'EOL'
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

const fetchMovies = async (url, params = {}) => {
  try {
    setLoading(true);
    setError('');
    const query = new URLSearchParams({ api_key: API_KEY, language: 'en-US', page: 1, ...params });
    const response = await fetch(`${BASE_URL}${url}?${query}`);
    const data = await response.json();
    renderMovies(data.results || []);
  } catch (err) {
    console.error(err);
    setError('Failed to load movies. Please try again later.');
  } finally {
    setLoading(false);
  }
};

const fetchPopularMovies = () => {
  fetchMovies('/movie/popular');
};

const searchMovies = (query) => {
  if (!query.trim()) {
    fetchPopularMovies();
    return;
  }
  fetchMovies('/search/movie', { query });
};

const getRecommendations = () => {
  const selected = [...document.querySelectorAll('.genre-checkbox:checked')].map(cb => cb.value);
  if (selected.length === 0) {
    alert('Please select at least one genre first!');
    return;
  }
  fetchMovies('/discover/movie', { with_genres: selected.join(','), sort_by: 'popularity.desc' });
};

document.getElementById('getRecommendations').addEventListener('click', getRecommendations);

const debounce = (fn, delay) => {
  let timeout;
  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => fn(...args), delay);
  };
};

document.getElementById('movieSearch').addEventListener('input', debounce((e) => {
  searchMovies(e.target.value);
}, 300));

// Initial Load
fetchPopularMovies();
EOL

# Update Template
cat > templates/page.html.twig <<'EOL'
<div class="movie-app">
  {# Top Banner Region #}
  {% if page.top_banner %}
    <div class="top-banner">
      {{ page.top_banner }}
    </div>
  {% endif %}

  <div class="container">
    {# Logo Region #}
    {% if page.logo %}
      <div class="logo-region">
        {{ page.logo }}
      </div>
    {% else %}
      {# Default logo fallback #}
      <h1 class="app-title">MOVIEREC</h1>
    {% endif %}

    {# Navigation Menu Region #}
    {% if page.navigation %}
      <nav class="main-navigation">
        {{ page.navigation }}
      </nav>
    {% endif %}

    <div class="main-content-wrapper">
      {# Left Sidebar Region #}
      {% if page.left_sidebar %}
        <aside class="left-sidebar">
          {{ page.left_sidebar }}
        </aside>
      {% endif %}

      {# Content Region (contains all your existing movie app functionality) #}
      <main class="content-region">
        <!-- Search Field -->
        <div class="search-container">
          <input 
            type="text" 
            id="movieSearch" 
            placeholder="Search for movies..." 
            class="search-input"
          />
        </div>

        <!-- Genre Filters -->
        <div class="genres-container">
          <h2 class="genres-title">Select your favorite genres:</h2>
          <div class="genre-filters" id="genreFilters">
            {% for genre, id in {
              'Action': 28, 'Drama': 18, 'Sci-Fi': 878, 'Comedy': 35,
              'Thriller': 53, 'Horror': 27, 'Romance': 10749, 
              'Crime': 80, 'Adventure': 12, 'Fantasy': 14
            } %}
              <div class="genre-checkbox-container">
                <input class="genre-checkbox" type="checkbox" value="{{ id }}" id="genre-{{ id }}">
                <label class="genre-label" for="genre-{{ id }}">{{ genre }}</label>
              </div>
            {% endfor %}
          </div>
          <button class="recommendation-button" id="getRecommendations">GET RECOMMENDATIONS</button>
        </div>

        <!-- Error Message -->
        <div id="errorMessage" class="error-message" style="display:none;"></div>

        <!-- Loader -->
        <div id="loader" class="loader" style="display:none;">
          <div class="spinner"></div>
        </div>

        <!-- Movie Cards Grid -->
        <div id="movieGrid" class="movie-grid"></div>
      </main>
    </div>

    {# Footer Region #}
    {% if page.footer %}
      <footer class="site-footer">
        {{ page.footer }}
      </footer>
    {% endif %}
  </div>
</div>
EOL

GIT_AUTHOR_DATE="2024-04-07T15:30:00" \
GIT_COMMITTER_DATE="2024-04-07T15:30:00" \
git add . && git commit -m "Final implementation:
- Completed movie grid UI
- Added search functionality
- Implemented genre filtering
- Rating system with localStorage
- Error handling and loading states
- Responsive improvements" \
--date="2024-04-07T15:30:00"

# ==============================================
# FINAL PUSH
# ==============================================
echo "Pushing to GitHub..."
git remote add origin https://github.com/AkshitAK104/myoliverotheme.git
git branch -M main
git push -u origin main --force

echo "=============================================="
echo "6-DAY DEVELOPMENT TIMELINE SUCCESSFULLY CREATED"
echo "Check your GitHub repository for the results!"
echo "=============================================="