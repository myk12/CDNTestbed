#!/bin/bash
##############################################################
#
#                        node-0
#                          |
#            node-1 _______|_______ node-2
#               |                     |
#           ____|____             ____|____
#          |         |           |         |
#       node-3    node-4       node-5   node-6
#
###############################################################
config_filename="nodelist.cfg"
declare -A node_map
declare -A node_parents
node_parents["node-1"]="node-0"
node_parents["node-2"]="node-0"
node_parents["node-3"]="node-1"
node_parents["node-4"]="node-1"
node_parents["node-5"]="node-2"
node_parents["node-6"]="node-2"

# parse file
while IFS=$'\t' read -r node_name rest_of_line; do
    # extract hostname
    host_name=$(echo "$rest_of_line" | awk -F'@' '{print $2}')
    
    # map nodename to hostname
    node_map["$node_name"]=$host_name
done < "$config_filename"

# echo info
echo "-------------------------------------------"
echo "  node   |          hostname               "
echo "-------------------------------------------"          
for node_name in "${!node_map[@]}"; do
    echo " $node_name  | ${node_map[$node_name]}"
done
echo "-------------------------------------------"

# get selt-name
self_name=`hostname | awk -F '.' '{print $1}'`

# set up node
if [ $self_name == "node-0" ]; then
    echo ">> no need to config ${self_name}"
    exit 1
else
    echo ">> setting ${self_name}"
fi

# install varnish
sudo apt-get install varnish -y
parent_name=${node_parents[${self_name}]}
echo ">> set $self_name point to $parent_name"
sed -i "s/\.host = \"[^\"]*\";/\.host = \"${node_map[$parent_name]}\";/g" default.vcl
if [ $parent_name == "node-0" ]; then
    sed -i "s/\.port = \"*\";/\.port = \"80\";/g" default.vcl
fi
sudo cp default.vcl /etc/varnish/default.vcl
