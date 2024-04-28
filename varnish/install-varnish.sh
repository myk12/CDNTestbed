#!/bin/bash

# install varnish
sudo apt-get install varnish

# varnish stat
crontab_cmd="0 * * * * /bin/bash /users/gtc/CDNTestbed/varnish/varnishstat.sh >> /users/gtc/varnishstat.log 2>&1"
crontab < (echo "${crontab_cmd}")
