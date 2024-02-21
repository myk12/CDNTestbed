#!/bin/bash

#!/bin/bash

# Install Golang

wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
go version

# Install IPFS kubo
wget https://dist.ipfs.tech/kubo/v0.26.0/kubo_v0.26.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.26.0_linux-amd64.tar.gz
cd kubo
sudo bash install.sh
cd ..

# Install Zsh
sudo apt update
sudo apt install zsh -y

yes | chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/.zshrc ~/.zshrc.bak
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
echo "alias ll='ls -alF'" >> ~/.zshrc


# Config environment

## go
export PATH="$PATH:/usr/local/go/bin"
echo "export PATH=\$PATH:/usr/local/go/bin/"  >> ~/.zshrc
go version

## ipfs
ipfs --version
ipfs init
cp swarm.key ~/.ipfs/



rm -rf *tar*
