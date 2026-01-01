Frontend:

Vue 3 (Composition API)

Vuetify 3

Vue Router

Axios



Backend:

Laravel 10+

Laravel Sanctum (Auth)

MySQL / MariaDB

RESTful API

Installation:
cd backend

composer install

cp .env.example .env

php artisan key:generate



setting .env:

DB\_DATABASE=project\_helpdesk

DB\_USERNAME=root

DB\_PASSWORD=


migration:

php artisan migrate
server:

php artisan serve



cd frontend

npm install

npm run dev

