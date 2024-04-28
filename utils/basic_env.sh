#!/bin/bash
sudo apt-get update
sudo apt-get install build-essential htop openssl jq -y

# config git
git config --global user.name "mayuke"
git config --global user.email "ykma22@m.fudan.edu.cn"
git config --global core.editor vim

# Install Golang
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
sudo rm -rf go1.22.0*
