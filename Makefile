# Makefile for HanLP Docker project

# Variables
IMAGE_NAME = hanlp-app
CONTAINER_NAME = hanlp-container

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
run:
	docker run -it --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Build and run in one command
all: build run

# Stop and remove the container
clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# Remove the Docker image
clean-image: clean
	docker rmi $(IMAGE_NAME)

.PHONY: build run all clean clean-image
