#!/bin/bash

# Update paket dan instalasi prerequisite
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Tambahkan GPG key untuk Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Tambahkan Docker repository ke APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update paket dan instal Docker
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Pastikan Docker sudah berjalan
sudo systemctl start docker
sudo systemctl enable docker

# Tambahkan user ke grup docker (ganti 'username' dengan user Anda)
sudo usermod -aG docker $USER

# Instalasi Docker Compose
DOCKER_COMPOSE_VERSION="2.0.0"
sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Berikan permission eksekusi
sudo chmod +x /usr/local/bin/docker-compose

# Verifikasi instalasi
docker --version
docker-compose --version

echo "Instalasi Docker dan Docker Compose telah selesai."
echo "Anda mungkin perlu logout dan login kembali untuk menerapkan perubahan grup Docker pada user Anda."
