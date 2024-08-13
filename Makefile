# Makefile to update the TeX Live repository and build the Docker image

# Default target
all: update-texlive build-docker

# Update the TeX Live repository
update-texlive:
	@echo "Updating TeX Live repository..."
	@./update_texlive.sh

# Build the Docker image
build-docker:
	@echo "Building Docker image..."
	@DOCKER_BUILDKIT=1 docker buildx build -t hub.informatica-global.com/informatica/pandoc-texlive-full:latest -t ghcr.io/informatica-global/pandoc-texlive-full .
	
# Push to local Registery
push:
	@echo "Building Docker image..."
	@docker push hub.informatica-global.com/informatica/pandoc-texlive-full

# Clean up
clean:
	@echo "Cleaning up..."
	@docker system prune
	@rm -f ./texlive/last_sync
