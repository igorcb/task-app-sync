# Makefile para facilitar comandos Docker

.PHONY: help build up down restart logs shell test db-create db-migrate db-reset clean

help: ## Exibir ajuda
	@echo "Comandos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Construir as imagens Docker
	docker-compose build

up: ## Iniciar os containers
	docker-compose up

up-d: ## Iniciar os containers em background
	docker-compose up -d

down: ## Parar e remover os containers
	docker-compose down

restart: ## Reiniciar os containers
	docker-compose restart

logs: ## Ver logs dos containers
	docker-compose logs -f web

shell: ## Abrir shell no container web
	docker-compose exec web bash

rails-console: ## Abrir Rails console
	docker-compose exec web bundle exec rails console

test: ## Executar testes
	docker-compose run --rm test

rspec: ## Executar RSpec com formatação detalhada
	docker-compose run --rm test bundle exec rspec --format documentation

db-create: ## Criar banco de dados
	docker-compose exec web bundle exec rails db:create

db-migrate: ## Executar migrations
	docker-compose exec web bundle exec rails db:migrate

db-seed: ## Popular banco de dados
	docker-compose exec web bundle exec rails db:seed

db-reset: ## Resetar banco de dados
	docker-compose exec web bundle exec rails db:drop db:create db:migrate

db-console: ## Abrir console do banco de dados
	docker-compose exec web bundle exec rails dbconsole

clean: ## Limpar containers, volumes e imagens
	docker-compose down -v
	docker system prune -f

install: ## Instalar gems
	docker-compose run --rm web bundle install

yarn-install: ## Instalar pacotes JavaScript
	docker-compose run --rm web yarn install

setup: build db-create db-migrate ## Setup inicial do projeto
	@echo "Projeto configurado com sucesso!"

fresh: clean build setup ## Rebuild completo do zero
	@echo "Projeto reconstruído do zero!"
