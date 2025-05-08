#!/bin/bash

set -e

echo "Checking if Docker is installed"

if command -v docker &> /dev/null; then
    echo "Docker is installed"
else
    echo "Docker is not installed"
    chmod +x ./install_docker.sh
    ./install_docker.sh
fi

echo "Checking if a container is already running"

if [ -n "$(docker ps -q -a)" ]; then
    echo "Yes!"
    echo "Stopping all of them"
    docker stop $(docker ps -q -a)
    docker rm $(docker ps -q -a)
    docker container prune -f
    docker image prune -f
fi


docker run -d -p 9092:9092 --name broker apache/kafka:latest
docker logs broker