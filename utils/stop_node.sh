#!/bin/bash

# stop docker containers
sudo docker stop $(sudo docker container ls | awk -F ' ' '{print$1}')

# restart varnish
sudo systemctl restart varnish

# clear varnish log
sudo rm -rf /users/gtc/varnishstat.log

# clear files
sudo rm -rf /home/uftp/*.dat
