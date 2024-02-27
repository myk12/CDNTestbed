#!/bin/bash

TEST_OBJECTS=("1KB.dat", "10KB.dat", "100KB.dat", "1MB.dat", "10MB.dat", "100MB.dat", "1GB.dat")
EPOCH_NUM=21

SERVER_NAME=amd225.utah.cloudlab.us
SERVER_PORT_H1=80
SERVER_PORT_H2=8443
SERVER_PORT_H3=8443
URL_PREFIX_HTTP="http://${SERVER_NAME}"
URL_PREFIX_HTTPS="https://${SERVER_NAME}"

CURRENT_TIME=`date "+%m-%d-%H-%M"`
LOG_FILENAME="./speed-test-${CURRENT_TIME}.log"
touch $LOG_FILENAME

# for loop
for i in $(seq 1 $EPOCH_NUM)
do
    echo "------- [${i}th test] -------"
    echo "===================== epoch [${i}] =====================" >> ${LOG_FILENAME}
    for item in "${TEST_OBJECTS[@]}"
    do
        echo "-------------- object [${item}] --------------" >> ${LOG_FILENAME}
        ## test http1.1
        url="${URL_PREFIX_HTTP}:${SERVER_PORT_H1}/${item}"
        echo  "HTTP1.1: ${url}" >> ${LOG_FILENAME}
        curl -k -o /dev/null -w "@curl-format.txt" $url >> ${LOG_FILENAME}

        ## test http2
        url="${URL_PREFIX_HTTPS}:${SERVER_PORT_H2}/${item}"
        echo "HTTP2: ${url}" >> ${LOG_FILENAME}
        curl -k -o /dev/null -w "@curl-format.txt" --http2 $url >> ${LOG_FILENAME}

        ## test http3
        url="${URL_PREFIX_HTTPS}:${SERVER_PORT_H3}/${item}"
        echo  "HTTP3: ${url}" >> ${LOG_FILENAME}
        curl -k -o /dev/null -w "@curl-format.txt" --http3-only $url >> ${LOG_FILENAME}

        ## test IPFS
    done

done