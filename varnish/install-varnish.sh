#!/bin/bash

# install varnish
sudo apt-get install varnish

# Define the crontab command
crontab_cmd="0 * * * * /bin/bash /users/gtc/CDNTestbed/varnish/varnishstat.sh >> /users/gtc/varnishstat.log 2>&1"

# Add the crontab entry using command substitution and process substitution
echo "${crontab_cmd}" | crontab -

# Alternatively, you can use the here-string (<<<) operator
# crontab <<< "${crontab_cmd}"
