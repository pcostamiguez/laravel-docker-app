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

Or clone your laravel app in ***src folder***.

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

Before build the compose, adjust the file src/package.json and **add in script section**:

```
"watch": "vite build --watch"
```

Then, build the project:

```
cd ..
```

```
docker compose up -d --build
```

Your app will be running at http://localhost/

