# Exercice 03 – Docker WordPress

## Architecture
- nginx : serveur web, envoie les fichiers .php à PHP.
- php : image php:8.3-fpm, avec l'extension mysqli et la dernière version de WordPress (téléchargée depuis wordpress.org/latest.tar.gz).
- mariadb : base de données.
- Volume commun wp_data : partagé entre nginx et php (fichiers et configuration de WordPress).
- Volume db_data : données de la base.

## Fichiers
- docker-compose.yaml : les 3 services et les volumes.
- nginx/default.conf : configuration nginx.
- php/Dockerfile : image PHP + WordPress.
- php/entrypoint.sh : copie WordPress dans le volume au premier démarrage.

## Lancement
- docker compose up -d --build
- Ouvrir http://localhost:8080
- Base de données : wordpress / utilisateur wpuser / mot de passe wppass / hôte db

## Résultat
WordPress 7.1.2 installé et fonctionnel. Les données sont conservées après un docker compose down puis up, grâce aux volumes.
