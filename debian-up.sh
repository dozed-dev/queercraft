#!/usr/bin/env bash

set -eu

packages=(
  # basic
  neovim git htop screen
  # for adding docker repo
  ca-certificates curl gnupg lsb-release
)

docker_packages=(
  docker-ce docker-ce-cli containerd.io docker-compose-plugin
)

apt update
apt install "${packages[@]}"

# add docker PGP key
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# add docker repo
echo "deb \
[arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list

# install docker
apt update
apt install "${docker_packages[@]}"

# run hello world
docker run hello-world

# allow docker to run on boot
systemctl enable --now docker.service containerd.service

# managing user
adduser minecraft --disabled-login --disabled-password
groupadd -f docker
usermod -aG docker minecraft
newgrp docker
