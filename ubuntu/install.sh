#!/bin/bash

# Creating new user
USER=$1

# Installing required modules
apt-get -y install autoconf libtool libpam-dev libssl-dev make curl

# Creating new user
echo "Creating $USER--"
sudo useradd -m -G sudo $USER
sudo mkdir -p /home/$USER/.ssh
# sudo cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
sudo cat /home/vagrant/.ssh/authorized_keys >> /home/$USER/.ssh/authorized_keys
sudo chmod 700 /home/$USER/.ssh
sudo chown $USER:$USER /home/$USER/.ssh
sudo chmod 600 /home/$USER/.ssh/authorized_keys
sudo chown $USER:$USER /home/$USER/.ssh/authorized_keys

# Installing Docker
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Installing pam_duo
sudo docker run \
    --rm \
    --volume /etc/ssh:/etc/ssh \
    --volume /etc/duo:/duo \
    --volume /lib64/security:/out \
    --volume /etc/pam.d:/etc/pam.d \
    --env-file duo.env \
    ankitjain28/pam_duo:ubuntu

# Restart sshd
sudo service ssh restart
