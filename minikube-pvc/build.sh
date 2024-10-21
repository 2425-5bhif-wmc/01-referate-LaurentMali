#!/usr/bin/env bash

# Convert repository name to lowercase
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | tr '[:upper:]' '[:lower:]')

mvn -B package
cp src/main/docker/Dockerfile target/
docker login ghcr.io -u $GITHUB_ACTOR -p $GITHUB_TOKEN
docker build --tag ghcr.io/$REPO_NAME/backend:latest ./target
docker push ghcr.io/$REPO_NAME/backend:latest