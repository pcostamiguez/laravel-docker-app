# Laravel Docker

First, clone this project to garb docker essentials files to build

```
git clone git@github.com:pcostamiguez/laravel-docker-app.git
```

After that:

```
cd laravel-docker-app/
```

Create a .env with content below:

```
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
REDIS_PASSWORD=laravel
```

Run command below to grab the latest version of laravel:

```
docker container run --rm -u ${UID}:${UID}  -v $(pwd):/app -w /app composer composer create-project --prefer-dist laravel/laravel src
```

Enter in src folder:

```
cd src/
```

Adjust the .env file (remember to insert same values from .env above):

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

```
cd ..
```

```
docker compose up -d
```

Your app will be running at http://localhost/

