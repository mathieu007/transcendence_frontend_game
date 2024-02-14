
all: build

prune:
	@if [ $$(docker ps -aq) ]; then \
		docker stop $$(docker ps -aq); \
		docker rm $$(docker ps -aq); \
	fi
	docker volume prune
	docker image prune -a -f
	docker system prune -f

re: prune all

exec:
	docker exec -it frontend_game-frontend_game_service-1 /bin/bash

down:
	docker compose -f ./docker-compose.yml down --remove-orphans \
	&& docker image prune \

build:
	docker compose -f ./docker-compose.yml down --remove-orphans \
	&& docker image prune \
	&& docker compose -f ./docker-compose.yml up -d --build \

.PHONY: all build down prune