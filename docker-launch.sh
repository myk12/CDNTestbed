#!/bin/bash
########################################################################
##
##          bash script to lauch docker containers
##
########################################################################
#
#   Usage: ./docker-launchsh server-addr server-port source-site-address
#

declare -A node_dir
node_dir["node-3"]="Atlanta"
node_dir["node-4"]="Los Angeles"
node_dir["node-5"]="New York"
node_dir["node-6"]="Seattle"

# commandline arguement
self_name=`hostname | awk -F '.' '{print $1}'`
self_path="./dataset/${node_dir[${self_name}]}"
echo $self_path
server_address=$1
server_port=$2
source_address=$3

# time related variable

if [ ! -d "$self_path" ]; then
    echo "none exists $self_path"
    exit 1
fi

# calculate start time
# get current minutes
current_timestamp=$(date +%s)
# next closet 10 minute
adjusted_timestamp=$((current_timestamp - (current_timestamp % 600) + 600))
readable_time=$(date -d "@$adjusted_timestamp")

##############################################################
#
#           LAUNCH CONTAINER FRO EACH TRACE
#
##############################################################
traces=$(ls "$self_path")
for trace in $traces; do
    echo "processing trace: $trace"
    # start docker container
    trace_file_path=$self_path"/"$trace
    echo $trace_file_path
    sudo docker run \
            -v "${trace_file_path}:/root/trace.dat" \
            -e "ENV_START_TIME=${adjusted_timestamp}" \
            -e "ENV_SERVER_ADDRESS=${server_address}" \
            -e "ENV_SERVER_PORT=${server_port}" \
	    -e "ENV_SOURCE_ADDRESS=${source_address}" \
            cdn-testbed &
done
