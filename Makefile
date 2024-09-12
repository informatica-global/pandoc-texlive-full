# Makefile to update the TeX Live repository and build the Docker image

# Default target
all: update-texlive build-docker

# Update the TeX Live repository
update-texlive:
	@echo "Make: Updating TeX Live repository..."
	@./update_texlive.sh

# Build the Docker image
build-docker:
	@echo "Building Docker image..."
	@DOCKER_BUILDKIT=1 docker buildx build --file localtexlive.Dockerfile -t ghcr.io/informatica-global/pandoc-texlive-full .
	
# Clean up
clean:
	@echo "Cleaning up...Prune, last_sync timestamp"
	@docker system prune
	@rm -f ./texlive/last_sync
