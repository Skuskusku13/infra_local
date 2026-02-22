COMPOSE_FILES := -f nginx/docker-compose.yml \
	-f mariadb/docker-compose.yml \
	-f logrotate/docker-compose.yml \
	-f prometheus-grafana/docker-compose.yml

PROJECT_NAME := infra_local

.PHONY: build up down logs help

help:
	@echo "Gestion de l'infrastructure locale"
	@echo "Commandes disponibles :"
	@echo "  make build  : Construit les images Docker"
	@echo "  make up     : Lance les conteneurs (en arrière-plan)"
	@echo "  make down   : Arrête et supprime les conteneurs (avec --remove-orphans)"
	@echo "  make logs   : Affiche les logs en temps réel"

build:
	cd services && docker compose --project-directory . -p $(PROJECT_NAME) $(COMPOSE_FILES) build

up:
	cd services && docker compose --project-directory . -p $(PROJECT_NAME) $(COMPOSE_FILES) up -d

down:
	cd services && docker compose --project-directory . -p $(PROJECT_NAME) $(COMPOSE_FILES) down --remove-orphans

logs:
	cd services && docker compose --project-directory . -p $(PROJECT_NAME) $(COMPOSE_FILES) logs -f
