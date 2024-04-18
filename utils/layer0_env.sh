#!/bin/bash

# install nginx-server
cd nginx_server
./install-nginx.sh
cd ..

# install vsftpd
cd ftpd
./install-vsftpd.sh
cd ..
