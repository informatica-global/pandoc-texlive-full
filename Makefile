# Define variables
LATEST_RELEASE := $(shell wget -q -O - "https://api.github.com/repos/jgm/pandoc/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')
IMAGE_NAME := ghcr.io/informatica-global/pandoc-texlive-full

# Default target
all: build

# Build the Docker image
build:
	docker buildx build --progress=plain --build-arg LATEST_RELEASE=$(LATEST_RELEASE) \
	-t $(IMAGE_NAME):$(LATEST_RELEASE) \
	-t $(IMAGE_NAME):latest .

# Push the Docker image to GitHub Container Registry
push: build
	docker push $(IMAGE_NAME):$(LATEST_RELEASE)
	docker push $(IMAGE_NAME):latest

# Clean up local Docker images
clean:
	docker rmi $(IMAGE_NAME):$(LATEST_RELEASE) $(IMAGE_NAME):latest || true
