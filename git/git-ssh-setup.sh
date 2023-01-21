#!/bin/bash
#
email=read -p "Enter your email: "
ssh-keygen -t ed25519 -C "${email}"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
#ssh -vT git@github.com
