# Laravel Docker

First, clone this project to garb docker essentials files to build

`git clone git@github.com:pcostamiguez/laravel-docker-app.git`

Run command below to grab the latest version of laravel:

```
docker container run --rm -u ${UID}:${UID}  -v $(pwd):/app -w /app composer composer create-project --prefer-dist laravel/laravel .
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

Then, build the project:

`docker compose up -d`

Your app will be running at http://localhost/

