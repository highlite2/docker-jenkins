PROJECT_NAME := docker-jenkins

.PHONE: run
run:
	docker-compose -p $(PROJECT_NAME) up --build -d jenkins-service

.PHONY: clean
clean:
	docker-compose -p $(PROJECT_NAME) down -v