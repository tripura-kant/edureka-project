#!/bin/bash
docker stop $(docker ps -aq) 
docker rm $(docker ps -aq)

# Autoincrement the version
VERSION=$(awk '{ print $1+1 }' version.txt)

# Build Docker Image
sudo docker build -t your-registry/edureka-cicd:${VERSION} .

# Deploy Docker container with the unique tag
sudo docker run -d -p 8081:8081 your-registry/edureka-cicd:${VERSION}

# Save the incremented version back to the file
echo ${VERSION} > version.txt
