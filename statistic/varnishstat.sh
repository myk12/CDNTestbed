#/bin/bash
# log file path
log_file="/users/gtc/varnishstat.log"

# write current timestamp
echo "[$(date)]------- [new epoch] ------" >> "$log_file"

# execute the command
sudo varnishstat -1 >> "$log_file"

# write stop timestamp
echo "[$(date)]------- [end epoch] -------" >> "$log_file"
