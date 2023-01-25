#!/bin/bash

#This is a simple script that automates the installation of docker and minikube on Ubuntu machines
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

#Download and install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Check if bash_aliases file exists and attempt to create
if [[ -e ${HOME}/.bash_aliases ]]; then
  echo "${HOME}/.bash_aliases already exists"
  read -p "Add kubectl alias to ${HOME}/.bash_aliases file? (Yy/Nn): " answer
  if [[ $answer == [Yy] ]]; then
    echo "Adding kubectl alias to ${HOME}/.bash_aliases"
    #Adds "kubectl" as an alias to minikube's native kubectl command
    echo alias kubectl=\"minikube kubectl --\" | sudo tee -a ${HOME}/.bash_aliases
  elif [[ $answer == [Nn] ]]; then
    exit 0
  fi    
else
  echo "creating ${HOME}/.bash_aliases file"
  #Creates a bash_aliases file
  touch ${HOME}/.bash_aliases
  #Adds "kubectl" as an alias to minikube's native kubectl command
  echo alias kubectl=\"minikube kubectl --\" | sudo tee -a ${HOME}/.bash_aliases
fi

#Show post-installation message on the terminal or at welcome screen
[[ -z "$USER" ]] && $(echo "To start minikube: use minikube start" | sudo tee -a /etc/motd) || echo "To start minikube: use minikube start"
[[ -z "$USER" ]] && $(echo "If minikube starts successfully, Try: kubectl get pod" | sudo tee -a /etc/motd) || echo "If minikube starts successfully, Try: kubectl get pod"

#dockergroup check function
dockergroupcheck() {
    if [[ $(getent group docker) ]]; then
      sudo usermod -aG docker $USER && echo "${USER} has been added to docker group" && newgrp docker
    else
      sudo groupadd docker && sudo usermod -aG docker $USER && echo "${USER} has been added to docker group" && newgrp docker
    fi
}

#checks if USER variable is empty. Useful if script is going to be used as a startup script
#e.g. Userdata for EC2-Instance
echo "Checking \$USER variable and adding to docker group....."
[[ -z "$USER" ]] && USER="ubuntu" && dockergroupcheck || dockergroupcheck
