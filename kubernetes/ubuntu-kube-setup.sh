#!/bin/bash

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

#Add user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#Download and start minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start 1> ${HOME}/kube_install.log
alias kubectl="minikube kubectl --"
echo "Try your first kubectl command. Ex: kubectl get pods"
echo "View minikube install log here `readlink -f ${HOME}/kube_install.log`"
