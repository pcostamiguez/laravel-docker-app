SHELL := /bin/bash
COMPOSE := docker compose

# Containers (ajusta nomes se forem diferentes)
PHP := php
NODE := node
DB := db

# -------------------------------------------------
# Help
# -------------------------------------------------

help: ## Lista todos os comandos disponíveis
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# -------------------------------------------------
# Infraestrutura
# -------------------------------------------------

up: ## Sobe containers (build incluso)
	$(COMPOSE) up -d --build

down: ## Derruba containers
	$(COMPOSE) down

restart: ## Reinicia containers
	$(COMPOSE) restart

logs: ## Logs em tempo real
	$(COMPOSE) logs -f

ps: ## Lista containers
	$(COMPOSE) ps

# -------------------------------------------------
# Node / Assets
# -------------------------------------------------

npm-install: ## Instala dependências npm
	$(COMPOSE) exec $(NODE) npm install

build: ## Builda assets produção
	$(COMPOSE) exec $(NODE) npm run build

watch: ## Watch assets
	$(COMPOSE) exec $(NODE) npm run watch

dev: ## Dev server (Vite)
	$(COMPOSE) exec $(NODE) npm run dev

build-once: ## Build isolado (container efêmero)
	$(COMPOSE) run --rm $(NODE) npm run build

# -------------------------------------------------
# Composer / PHP
# -------------------------------------------------

composer-install: ## Instala dependências PHP
	$(COMPOSE) exec $(PHP) composer install

composer-update: ## Atualiza dependências PHP
	$(COMPOSE) exec $(PHP) composer update

dump-autoload: ## Regera autoload
	$(COMPOSE) exec $(PHP) composer dump-autoload

# -------------------------------------------------
# Artisan — Geral
# -------------------------------------------------

artisan: ## Executa artisan custom (make artisan cmd="migrate")
	$(COMPOSE) exec $(PHP) php artisan $(cmd)

key-generate: ## Gera APP_KEY
	$(COMPOSE) exec $(PHP) php artisan key:generate

about: ## Info do Laravel
	$(COMPOSE) exec $(PHP) php artisan about

route-list: ## Lista rotas
	$(COMPOSE) exec $(PHP) php artisan route:list

config-show: ## Mostra configs
	$(COMPOSE) exec $(PHP) php artisan config:show

# -------------------------------------------------
# Migrations / Database
# -------------------------------------------------

migrate: ## Roda migrations
	$(COMPOSE) exec $(PHP) php artisan migrate

migrate-fresh: ## Refaz DB do zero
	$(COMPOSE) exec $(PHP) php artisan migrate:fresh

migrate-seed: ## Migrate + seed
	$(COMPOSE) exec $(PHP) php artisan migrate --seed

seed: ## Executa seeders
	$(COMPOSE) exec $(PHP) php artisan db:seed

fresh-seed: ## Fresh + seed
	$(COMPOSE) exec $(PHP) php artisan migrate:fresh --seed

rollback: ## Rollback migration
	$(COMPOSE) exec $(PHP) php artisan migrate:rollback

db-shell: ## Shell MariaDB/MySQL
	$(COMPOSE) exec $(DB) mariadb -u root -p

# -------------------------------------------------
# Cache / Optimize
# -------------------------------------------------

optimize: ## Otimizações Laravel
	$(COMPOSE) exec $(PHP) php artisan optimize

optimize-clear: ## Limpa otimizações
	$(COMPOSE) exec $(PHP) php artisan optimize:clear

cache-clear: ## Limpa cache app
	$(COMPOSE) exec $(PHP) php artisan cache:clear

config-clear: ## Limpa config cache
	$(COMPOSE) exec $(PHP) php artisan config:clear

route-clear: ## Limpa rotas cache
	$(COMPOSE) exec $(PHP) php artisan route:clear

view-clear: ## Limpa views
	$(COMPOSE) exec $(PHP) php artisan view:clear

event-clear: ## Limpa events cache
	$(COMPOSE) exec $(PHP) php artisan event:clear

cache-rebuild: ## Rebuild completo cache
	$(COMPOSE) exec $(PHP) php artisan config:cache
	$(COMPOSE) exec $(PHP) php artisan route:cache
	$(COMPOSE) exec $(PHP) php artisan view:cache

# -------------------------------------------------
# Storage / Permissões
# -------------------------------------------------

storage-link: ## Cria symlink storage
	$(COMPOSE) exec $(PHP) php artisan storage:link

permissions: ## Ajusta permissões Laravel
	$(COMPOSE) exec $(PHP) chown -R www-data:www-data storage bootstrap/cache

# -------------------------------------------------
# Testes / Qualidade
# -------------------------------------------------

test: ## Testes Laravel
	$(COMPOSE) exec $(PHP) php artisan test

pest: ## Pest PHP
	$(COMPOSE) exec $(PHP) ./vendor/bin/pest

phpunit: ## PHPUnit
	$(COMPOSE) exec $(PHP) ./vendor/bin/phpunit

# -------------------------------------------------
# Filas / Scheduler
# -------------------------------------------------

queue-work: ## Worker filas
	$(COMPOSE) exec $(PHP) php artisan queue:work

queue-restart: ## Restart workers
	$(COMPOSE) exec $(PHP) php artisan queue:restart

schedule-run: ## Executa scheduler
	$(COMPOSE) exec $(PHP) php artisan schedule:run

# -------------------------------------------------
# Debug / Shells
# -------------------------------------------------

php-shell: ## Shell no container PHP
	$(COMPOSE) exec $(PHP) sh

node-shell: ## Shell no container Node
	$(COMPOSE) exec $(NODE) sh

tinker: ## REPL Laravel
	$(COMPOSE) exec $(PHP) php artisan tinker
