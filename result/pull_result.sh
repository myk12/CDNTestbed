#!/bin/bash

declare -A node_name
node3_fullname=""
node4_fullname=""
node5_fullname=""
node6_fullname=""

node3_name=$(echo ${node3_fullname} | awk -F ' ' '{print$1}')
scp $node3_name:/users/gtc/varnishstat.log ./varnishstat-node3.log

node4_name=$(echo ${node4_fullname} | awk -F ' ' '{print$1}')
scp $node4_name:/users/gtc/varnishstat.log ./varnishstat-node4.log

node5_name=$(echo ${node5_fullname} | awk -F ' ' '{print$1}')
scp $node5_name:/users/gtc/varnishstat.log ./varnishstat-node5.log

node6_name=$(echo ${node6_fullname} | awk -F ' ' '{print$1}')
scp $node6_name:/users/gtc/varnishstat.log ./varnishstat-node6.log

