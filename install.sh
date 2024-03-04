#source: https://github.com/vinyll/docker-install
#!/bin/bash

set +e

# Cleanup any previous version
sudo apt-get remove docker docker-engine docker.io containerd runc

# Get pre-requirements
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
#if your vps is  Pi or arm64 use this command instead
# echo \
#  "deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Prevent GPG error
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

# Install Docker and Compose
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo ""
echo "Docker and Docker compose are properly installed."
docker --version

#install docker-compose
#add user to group docker
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# if vps is arm (Pi - oracle)
# Install required packages
# sudo apt update
# sudo apt install -y python3-pip libffi-dev

# Install Docker Compose from pip (using Python3)
# This might take a while
# sudo pip install docker-compose
docker-compose --version
