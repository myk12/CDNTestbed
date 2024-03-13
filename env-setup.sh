#!/bin/bash
TOP_DIR=`pwd`

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

#### RUN HTTP SUB SCRIPT ####
cd http
./install-nginx.sh
cd ..

#### RUN CURL3 SUB SCRIPT ####
cd curl3
./install-curl3.sh

#### GENERATE TEST FILES ####
cd $TOP_DIR
go run ./utils/file-generator.go --size=1KB
go run ./utils/file-generator.go --size=10KB
go run ./utils/file-generator.go --size=100KB
go run ./utils/file-generator.go --size=1MB
go run ./utils/file-generator.go --size=10MB
go run ./utils/file-generator.go --size=100MB
go run ./utils/file-generator.go --size=1GB
go run ./utils/file-generator.go --size=10GB
sudo mv *.dat /usr/local/nginx/html/

