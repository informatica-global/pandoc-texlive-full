# Define variables
LATEST_RELEASE := 3.2.1
IMAGE_NAME := ghcr.io/informatica-global/pandoc-texlive-full
LOCAL_IMAGE_TAG := $(shell docker images --format "{{.Tag}}" $(IMAGE_NAME) | grep -v latest | sort -rV | head -n 1)

# Default target
all: check_version build

# Check if the LATEST_RELEASE is higher than LOCAL_IMAGE_TAG
check_version:
	@if [ "$(LATEST_RELEASE)" != "$(LOCAL_IMAGE_TAG)" ] && [ "$(LATEST_RELEASE)" != "" ] && [ "$(LOCAL_IMAGE_TAG)" != "" ] && [ `echo -e "$(LOCAL_IMAGE_TAG)\n$(LATEST_RELEASE)" | sort -V | head -n 1` != "$(LATEST_RELEASE)" ]; then \
		echo "New version detected will add a git tag v$(LATEST_RELEASE)"; \
		git tag v$(LATEST_RELEASE); \
		echo "Please consider running 'git push origin v"$(LATEST_RELEASE)"'"; \
	fi

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
