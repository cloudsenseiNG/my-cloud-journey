#!/bin/bash

#This is a simple script that automates the installation of docker and minikube on your machine
#System Requirements 
#RAM: At least 2GB
#Processor: A CPU with at least 2 vCores
#Storage: At least 20GB of storage

#Install docker
sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Download and start minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Creates an alias file and adds "kubectl" to minikube's native kubectl command
touch ${HOME}/.bash_aliases
echo alias kubectl=\"minikube kubectl --\" | sudo tee -a ${HOME}/.bash_aliases

echo "To start minikube: use minikube start"
echo "If minikube starts successfully, Try: kubectl get pod"

#Add user to docker group and switch to docker group
sudo usermod -aG docker $USER && newgrp docker
