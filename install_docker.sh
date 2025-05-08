#!/bin/bash

set -e

echo "Installing Docker.."
echo "Removing Conflicting dependencies"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt-get remove -y $pkg; done
echo "Installing curl and certificates"
apt-get install -y ca-certificates curl
echo "Installing keyrings"
install -m 0755 -d /etc/apt/keyrings
echo "Getting docker installer"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "Making the docker installer executable"
chmod a+r /etc/apt/keyrings/docker.asc
echo "Executing docker installer and updating"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release \
    && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Docker installation completed"