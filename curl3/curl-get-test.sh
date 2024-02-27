#!/bin/bash

## TEST epoch
EPOCH_NUM=21

## FILE NAME and CID
TEST_OBJECTS=("1KB.dat" "10KB.dat" "100KB.dat" "1MB.dat" "10MB.dat" "100MB.dat" "1GB.dat")
declare -A file_to_cid
file_to_cid["1KB.dat"]="QmQXesoMt2KWTxnVcGwxqwThSNzBy2gsXr1DANTJtLjc1k"
file_to_cid["10KB.dat"]="QmcqBd6EuU4BiBJkArSFLbNHnM8tbC9vu9a4AbqTq4gHAL"
file_to_cid["100KB.dat"]="QmVFxmvDaBBGBFUMPLSRL9mb4N6Xm8xEYnCuy5m85gPAaP"
file_to_cid["1MB.dat"]="QmVkbauSDEaMP4Tkq6Epm9uW75mWm136n81YH8fGtfwdHU"
file_to_cid["10MB.dat"]="QmaJ6kN9fW3TKpVkpf1NuW7cjhHjNp5Jwr3cQuHzsoZWkJ"
file_to_cid["100MB.dat"]="Qmca3PNFKuZnYkiVv1FpcV1AfDUm4qCSHoYjPTBqDAsyk8"
file_to_cid["1GB.dat"]="QmdiETTY5fiwTkJeERbWAbPKtzcyjzMEJTJJosrqo2qKNm"
#file_to_cid["10GB.dat"]="QmaBQKueEF3pi8mdpecQQvxi96LzMRaup3CAn3Jr9P5W2M"

## SERVER INFO
SERVER_NAME=amd225.utah.cloudlab.us
SERVER_PORT_H1=80
SERVER_PORT_H2=8443
SERVER_PORT_H3=8443
URL_PREFIX_HTTP="http://${SERVER_NAME}"
URL_PREFIX_HTTPS="https://${SERVER_NAME}"

## LOG FILE INFO
CURRENT_TIME=`date "+%m-%d-%H-%M"`
LOG_FILENAME="./speed-test-${CURRENT_TIME}.log"
touch $LOG_FILENAME

## OUTPUT DIR
OUTPUT_DIR="/tmp/http-ipfs-test/"
OUTPUT_PATH="${OUTPUT_DIR}/file.dat"
mkdir -p $OUTPUT_DIR

# main loop
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
        curl -k -o $OUTPUT_PATH -w "@curl-format.txt" $url >> ${LOG_FILENAME}

        ## test http2
        url="${URL_PREFIX_HTTPS}:${SERVER_PORT_H2}/${item}"
        echo "HTTP2: ${url}" >> ${LOG_FILENAME}
        curl -k -o $OUTPUT_PATH -w "@curl-format.txt" --http2 $url >> ${LOG_FILENAME}

        ## test http3
        url="${URL_PREFIX_HTTPS}:${SERVER_PORT_H3}/${item}"
        echo  "HTTP3: ${url}" >> ${LOG_FILENAME}
        curl -k -o $OUTPUT_PATH -w "@curl-format.txt" --http3-only $url >> ${LOG_FILENAME}

        ## test IPFS
        echo "IPFS: ipfs://${file_to_cid[${item}]}" >> ${LOG_FILENAME}
        /usr/bin/time -f "real: %E\nuser: %U\nsys: %S\n" -a -o ${LOG_FILENAME} ipfs get ${file_to_cid[${item}]} -o ${OUTPUT_PATH}

        ## clean outpu dir
        sudo rm -rf "$OUTPUT_DIR/*"
    done

done