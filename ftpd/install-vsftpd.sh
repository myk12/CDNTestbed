#!/bin/bash

sudo apt-get update
sudo apt-get install -y vsftpd

# add uftp user
sudo useradd -m uftp
# set password
echo "uftp:uftp" | sudo chpasswd

# set configuration
sudo cp vsftpd.conf /etc/
sudo cp vsftpd.user_list /etc/
