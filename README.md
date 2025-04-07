# 🎬 MyOliveroTheme – Custom Drupal 10 Movie Theme

## 🎯 Project Objective

The goal of this project is to build a smart Movie Recommendation System within a custom Drupal theme based on Olivero. It integrates the TMDB API to deliver personalized film suggestions through an engaging user interface.

Features like genre-based filtering, search-as-you-type, and user movie ratings (stored via `localStorage`) make the experience smooth and interactive. Designed to be responsive and accessible, the theme leverages Drupal's templating power to create a modern, user-friendly experience directly within the CMS.

## 📄 Project Documentation

For detailed information about the project's objectives, functionalities, and architecture, refer to the full documentation:

➡️ [View Full PDF Documentation](./drupal-olivero-project-information.pdf)

---

## ✅ Requirements

Before getting started, ensure you have the following tools installed and set up on your local machine:

1. **🐳 Docker** – Docker Desktop must be installed and running to run containers for local development.  
   👉 [Download Docker](https://www.docker.com/products/docker-desktop/)

2. **⚙️ DDEV** – Used to spin up a containerized Drupal instance quickly.  
   👉 [Install DDEV](https://ddev.readthedocs.io/en/stable/)

3. **🌐 Internet Connection** – Required for downloading Docker images and fetching dependencies on the first run.

4. **🧰 Drush** – A command-line utility for managing Drupal (included with DDEV).

5. **🛠 Composer** – PHP dependency manager for managing Drupal modules, themes, and libraries.  
   👉 [Install Composer](https://getcomposer.org/download/)

6. **💻 Git** – Required for cloning and managing the project repository.

---

## 🚀 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. Start DDEV:
   ```bash
   ddev start
   ```

3. Install the site:
   ```bash
   ddev drush site:install
   ```

4. Rebuild cache:
   ```bash
   ddev drush cr
   ```

5. Enable the theme:
   ```bash
   ddev drush theme:enable myoliverotheme
   ```

6. Set it as the default theme:
   ```bash
   ddev drush config-set system.theme default myoliverotheme
   ```

> 🔁 Replace `"myoliverotheme"` with your actual theme folder name if it differs.

6. Launch the LocalHost:
   ```bash
   ddev launch
  
   ```
---
