#!/bin/bash

# Create User/Group jenkins:jenkin
sudo groupadd jenkins
sudo usedadd -M jenkins -g jenkins
sudo usermod -aG jenkins jenkins

echo "Create Jenkins Docker Volume"
docker volume create jenkins-data
echo "Create Jenkins Docker bridge network"
docker network create jenkins

echo "Creating Jenkins Docker container with name (jenkins-docker)"
docker run --name jenkins-docker --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --privileged \
  docker.io/allnash/jenkins:v1.1
