#!/bin/bash

TEST_OBJECTS=("1KB.dat", "10KB.dat", "100KB.dat", "1MB.dat", "10MB.dat", "100MB.dat", "1GB.dat", "10GB.dat")
EPOCH_NUM=100

SERVER_NAME=amd225.utah.cloudlab.us
SERVER_PORT_H1=80
SERVER_PORT_H2=8443
SERVER_PORT_H3=8443
URL_PREFIX="https://${SERVER_NAME}"

# for loop
for i in $(seq 1 $EPOCH_NUM)
do
    echo "------- [${i}th test] -------"
    for item in "${TEST_OBJECTS[@]}"
    do
        ## test http1.1
        url="${URL_PREFIX}:${SERVER_PORT_H1}/${item}"
        echo $url
        #curl -k -o /del/null -w "@curl-format.txt" $url

        ## test http2
        url="${URL_PREFIX}:${SERVER_PORT_H2}/${item}"
        echo $url
        curl -k -o /dev/null -w "@curl-format.txt" --http2 $url

        ## test http3
        url="${URL_PREFIX}:${SERVER_PORT_H3}/${item}"
        echo $url
        curl -k -o /dev/null -w "@curl-format.txt" --http3-only $url

        ## test IPFS
    done

done