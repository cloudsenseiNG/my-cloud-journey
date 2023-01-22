#!/bin/bash

#Color_Variables

red="\033[31;3m"
no_color="\033[0m"


#Reads text input
read -p "Enter your email: " email

echo -e "Supported Key Types: ${red}\ndsa \necdsa \necdsa-sk \ned25519 \ned25519-sk \nrsa${no_color}"

read -p "Enter your key type: " type

#Generates SSH key
ssh-keygen -t ${type} -C "${email}"

#Starts SSH agent with output
eval "$(ssh-agent -s)"

#Adds private key to ssh-agent
ssh-add ~/.ssh/id_${type}

#Prints public key
echo -e "Copy this key: $red $(cat ~/.ssh/id_${type}.pub) $no_color and add to GitHub SSH keys"
