# Makefile for HanLP Docker project

# Variables
IMAGE_NAME = hanlp-app
CONTAINER_NAME = hanlp-container

# Default target: build and run
all: build run

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
run:
	docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Stop and remove the container
clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# Remove the Docker image
clean-image: clean
	docker rmi $(IMAGE_NAME)

.PHONY: build run all clean clean-image
