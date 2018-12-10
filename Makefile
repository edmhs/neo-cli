TAG=latest
PROJECT=neo-cli
USER=edmhs
IMAGE=neo-cli

build:
	docker build -t $(USER)/$(IMAGE):$(TAG) -f ./Dockerfile .

rebuild:
	docker build -t $(USER)/$(IMAGE):$(TAG) --no-cache -f ./Dockerfile .

# used for pushing image to registry
push:
	docker push $(USER)/$(IMAGE):$(TAG)

create-network:
	docker network create neo

run:
	docker-compose -f ./docker-compose.yml --project-name $(PROJECT) up -d

restart:
	docker-compose -f ./docker-compose.yml --project-name $(PROJECT) restart
	
down:
	docker-compose -f ./docker-compose.yml --project-name $(PROJECT) down

exec:
	docker exec -it $(IMAGE) bash

logs:
	docker logs $(IMAGE) -f

# attach client node screen session, to detach from screen and keep it running (CTRL+A then CTRL+D)
cli:
	docker exec -it $(IMAGE) screen -r node 