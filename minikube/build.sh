#!/usr/bin/env bash

# Convert repository name to lowercase
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | tr '[:upper:]' '[:lower:]')

# Ensure the script is executed from the correct directory
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR" || exit 1

# Ensure the Dockerfile exists
if [ ! -f src/main/docker/Dockerfile ]; then
  echo "Dockerfile not found!"
  exit 1
fi

# Package the application with Maven
mvn -B package

# Ensure the target directory exists
if [ ! -d target ]; then
  echo "Target directory not found!"
  exit 1
fi

# Copy the Dockerfile to the target directory
cp src/main/docker/Dockerfile target/

# Login to GitHub Container Registry
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_ACTOR" --password-stdin

# Build and push the Docker image
docker build --tag ghcr.io/"$REPO_NAME"/backend:latest ./target
docker push ghcr.io/"$REPO_NAME"/backend:latest