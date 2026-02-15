# Laravel Docker

First, run command below to grab the latest version of laravel:

```
docker container run --rm -u ${UID}:${UID}  -v $(pwd):/app -w /app composer composer create-project --prefer-dist laravel/laravel laravel-docker-app
```

After that:

`cd laravel-docker-app/`

Create the .env file:

```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
REDIS_PASSWORD=laravel
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
REDIS_HOST=redis
PHP_CLI_SERVER_WORKERS=4
```


Clone this project to garb docker essentials files to build

`git clone github.com/pcostamiguez/laraveldocker.git . `

Then, build the project:

`docker compose up -d`

Generate a key for laravel:

`docker compose exec php php artisan key:generate`

Your app will be running at http://localhost/

