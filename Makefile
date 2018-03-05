PROJECT_NAME := highlite2-docker-jenkins
COMPOSE_FILE := docker-compose.yml

.PHONE: run
run:
	docker-compose pull
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d

.PHONY: stop
stop:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) stop

.PHONY: clean
clean:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down -v

# Checking if config exists
ifeq ("$(wildcard config.env)","")
  $(error config.env file not found. Run "cp _config.env config.env" and override default values)
endif