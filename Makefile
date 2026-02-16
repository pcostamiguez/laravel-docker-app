SHELL := /bin/bash
COMPOSE := docker compose

# Containers (ajusta nomes se forem diferentes)
PHP := php
NODE := node
DB := db

# -------------------------------------------------
# Infraestrutura
# -------------------------------------------------

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

# -------------------------------------------------
# Node / Assets
# -------------------------------------------------

npm-install:
	$(COMPOSE) exec $(NODE) npm install

build:
	$(COMPOSE) exec $(NODE) npm run build

watch:
	$(COMPOSE) exec $(NODE) npm run watch

dev:
	$(COMPOSE) exec $(NODE) npm run dev

# Se container node não ficar vivo
build-once:
	$(COMPOSE) run --rm $(NODE) npm run build

# -------------------------------------------------
# Composer / PHP
# -------------------------------------------------

composer-install:
	$(COMPOSE) exec $(PHP) composer install

composer-update:
	$(COMPOSE) exec $(PHP) composer update

dump-autoload:
	$(COMPOSE) exec $(PHP) composer dump-autoload

# -------------------------------------------------
# Artisan — Geral
# -------------------------------------------------

artisan:
	$(COMPOSE) exec $(PHP) php artisan $(cmd)

key-generate:
	$(COMPOSE) exec $(PHP) php artisan key:generate

about:
	$(COMPOSE) exec $(PHP) php artisan about

route-list:
	$(COMPOSE) exec $(PHP) php artisan route:list

config-show:
	$(COMPOSE) exec $(PHP) php artisan config:show

# -------------------------------------------------
# Migrations / Database
# -------------------------------------------------

migrate:
	$(COMPOSE) exec $(PHP) php artisan migrate

migrate-fresh:
	$(COMPOSE) exec $(PHP) php artisan migrate:fresh

migrate-seed:
	$(COMPOSE) exec $(PHP) php artisan migrate --seed

seed:
	$(COMPOSE) exec $(PHP) php artisan db:seed

fresh-seed:
	$(COMPOSE) exec $(PHP) php artisan migrate:fresh --seed

rollback:
	$(COMPOSE) exec $(PHP) php artisan migrate:rollback

# Shell no banco (MariaDB/MySQL)
db-shell:
	$(COMPOSE) exec $(DB) mariadb -u root -p

# -------------------------------------------------
# Cache / Optimize
# -------------------------------------------------

optimize:
	$(COMPOSE) exec $(PHP) php artisan optimize

optimize-clear:
	$(COMPOSE) exec $(PHP) php artisan optimize:clear

cache-clear:
	$(COMPOSE) exec $(PHP) php artisan cache:clear

config-clear:
	$(COMPOSE) exec $(PHP) php artisan config:clear

route-clear:
	$(COMPOSE) exec $(PHP) php artisan route:clear

view-clear:
	$(COMPOSE) exec $(PHP) php artisan view:clear

event-clear:
	$(COMPOSE) exec $(PHP) php artisan event:clear

# Rebuild completo de cache
cache-rebuild:
	$(COMPOSE) exec $(PHP) php artisan config:cache
	$(COMPOSE) exec $(PHP) php artisan route:cache
	$(COMPOSE) exec $(PHP) php artisan view:cache

# -------------------------------------------------
# Storage / Permissões
# -------------------------------------------------

storage-link:
	$(COMPOSE) exec $(PHP) php artisan storage:link

permissions:
	$(COMPOSE) exec $(PHP) chown -R www-data:www-data storage bootstrap/cache

# -------------------------------------------------
# Testes / Qualidade
# -------------------------------------------------

test:
	$(COMPOSE) exec $(PHP) php artisan test

pest:
	$(COMPOSE) exec $(PHP) ./vendor/bin/pest

phpunit:
	$(COMPOSE) exec $(PHP) ./vendor/bin/phpunit

# -------------------------------------------------
# Filas / Scheduler
# -------------------------------------------------

queue-work:
	$(COMPOSE) exec $(PHP) php artisan queue:work

queue-restart:
	$(COMPOSE) exec $(PHP) php artisan queue:restart

schedule-run:
	$(COMPOSE) exec $(PHP) php artisan schedule:run

# -------------------------------------------------
# Debug / Shells
# -------------------------------------------------

php-shell:
	$(COMPOSE) exec $(PHP) sh

node-shell:
	$(COMPOSE) exec $(NODE) sh

tinker:
	$(COMPOSE) exec $(PHP) php artisan tinker
