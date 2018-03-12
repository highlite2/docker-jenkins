PROJECT_NAME := highlite2-jenkins
COMPOSE_FILE := docker-compose.yml

JENKINS_CONTAINER_ID := $$(docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) ps -q jenkins)

.PHONE: run
run:
	docker volume create --name highlite2-jenkins-home
	docker-compose pull
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d

.PHONY: stop
stop:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) stop

.PHONY: admin-password
admin-password:
	docker exec -ti $(JENKINS_CONTAINER_ID) cat /var/jenkins_home/secrets/initialAdminPassword

.PHONY: clean
clean:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down -v

# Checking if config exists
ifeq ("$(wildcard config.env)","")
  $(error config.env file not found. Run "cp _config.env config.env" and override default values)
endif