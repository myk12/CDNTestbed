#!/bin/bash

sudo apt-get update 
sudo apt-get install build-essential htop openssl -y

# config git
git config --global user.name "mayuke"
git config --global user.email "ykma22@m.fudan.edu.cn"
git config --global core.editor vim


# Install Golang

wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
sudo rm -rf go1.22.0*

# Install IPFS kubo
wget https://dist.ipfs.tech/kubo/v0.26.0/kubo_v0.26.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.26.0_linux-amd64.tar.gz
cd kubo
sudo bash install.sh
cd ..
rm -rf kubo*

# Config environment

## go
export PATH="$PATH:/usr/local/go/bin"
echo "export PATH=\$PATH:/usr/local/go/bin/"  >> ~/.bashrc
go version

## ipfs
ipfs --version
ipfs init
cp ./ipfs/swarm.key ~/.ipfs/

rm -rf *tar*
