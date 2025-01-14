# Variables
IMAGE_NAME := gpu-ssh-image
CONTAINER_NAME := gpu-ssh-container
PORT := 2222
DOCKER_REGISTRY := xinkaiw
REGISTRY_IMAGE_NAME := $(DOCKER_REGISTRY)/$(IMAGE_NAME)
TAG := 0.1

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Tag the image for the Docker registry
tag:
	docker tag $(IMAGE_NAME) $(REGISTRY_IMAGE_NAME):$(TAG)

# Push the image to the Docker registry
push: tag
	docker push $(REGISTRY_IMAGE_NAME):$(TAG)

# Login to Docker registry (optional)
login:
	docker login

# Run the Docker container
run:
	docker run -d -p $(PORT):22 --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Stop the Docker container
stop:
	docker stop $(CONTAINER_NAME)

# Remove the Docker container
remove:
	docker rm $(CONTAINER_NAME)

# Restart the Docker container
restart: stop remove run

# Clean up dangling images
clean-images:
	docker image prune -f

# Clean up stopped containers
clean-containers:
	docker container prune -f

# Show running containers
ps:
	docker ps

# Show all containers (including stopped ones)
ps-all:
	docker ps -a

# Show logs for the container
logs:
	docker logs -f $(CONTAINER_NAME)

# SSH into the running container
ssh:
	ssh -i ~/.ssh/id_rsa root@localhost -p $(PORT)
