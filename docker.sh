#!/bin/bash

# Stop and remove existing containers (force quitting errors)
docker stop $(docker ps -aq) || true
docker rm $(docker ps -aq) || true

# Autoincrement the version
VERSION=$(awk '{ print $1+1 }' version.txt)

# Build Docker Image
docker build -t your-registry/edureka-cicd:${VERSION} .

# Deploy Docker container with the unique tag
docker run -d -p 8081:8081 your-registry/edureka-cicd:${VERSION}

# Save the incremented version back to the file
echo ${VERSION} > version.txt
