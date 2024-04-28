#!/bin/bash
# set up basic environment
cd utils
./basic_env.sh
cd ..

# install HTTP (nginx) server
echo "------- Installing Nginx Server -------"
cd nginx_server
./install-nginx.sh
cd ..

# install FTP (vsftpd) server
echo "------- Installing Vsftpd Server -------"
cd ftpd
./install-vsftpd.sh
