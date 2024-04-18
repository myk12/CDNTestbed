#!/bin/bash
TOP_DIR=`pwd`

sudo apt-get update

# setup basic environment
./utils/basic_env.sh

# config this node
## get node name
node_name=$(uname -n | awk -F . '{print $1}')
echo "node name ${self_name}"

# Parse JSON and extract node information
node_info=$(jq --arg node "$node_name" '
    .topology as $topology |
    keys[] as $layer |
    $topology[$layer][] |
    select(.name == $node) |
    { "layer": $layer, "parent": if $layer == "layer-0" then null else $layer[:-1] + ([(. | map_values(ascii_downcase)) | .id] | join("-")) end }
' config.json)

