#!/bin/bash
########################################################################
##
##          bash script to lauch docker containers
##
########################################################################
#
#   Usage: ./docker-launchsh current-project-path server-addr server-port
#

declare -A node_dir
node_dir["node-3"]="aisa-node"
node_dir["node-4"]="europe-node"
node_dir["node-5"]="america-node"
node_dir["node-6"]="latin-node"

# commandline arguement
self_name=`hostname | awk -F '.' '{print $1}'`
self_path="$1/dataset/${node_dir[${self_name}]}"
echo $self_path
server_address=$2
server_port=$3

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
            -e "ENV_SERVER_ADDRESS=${server_addr}" \
            -e "ENV_SERVER_PORT=${server_port}" \
            cdn-testbed &
done
