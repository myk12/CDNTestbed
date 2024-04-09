#!/bin/sh
# input trace
trace_filename="/root/trace.dat"
log_filename="/root/actions.log"
# read each line of trace
# remove the first lines
sed '1,1d; $!N; P; D' "${trace_filename}" > temp_file.txt
cat temp_file.txt > $trace_filename

start_time=${ENV_START_TIME}
server_address=${ENV_SERVER_ADDRESS}
server_port=${ENV_SERVER_PORT}

# generate URL
url_prefix="http://${server_address}:${server_port}/"

if [ ! -f "$trace_filename" ]; then
    echo "trace file none exist"
    exit 1
fi
touch log_filename

##################################
#
#   execute traces
#
##################################

while IFS="," read -r seq user_id abs_ts act_type object_name object_size liked offset_ts; do
    curr_ts=$(date +%s)
    echo "offset_ts = ${offset_ts}"
    target_ts=$((start_time + offset_ts))

    echo "next action time : ${target_ts}"
    time_wait=$((target_ts - curr_ts))
    echo "need to wait ${time_wait} seconds"

    # sleep for 
    #sleep $time_wait
    # only for test
    sleep 7

    curr_time=$(date)
    # act
    if [ "${act_type}" = "POST" ]; then
        log_msg="-[${curr_time}] POST ${object_name}"
        echo $log_msg
        echo $log_msg >> $log_filename
        /root/post_content.sh $user_id $object
    elif [ "${act_type}" = "GET" ]; then
        object_url="${url_prefix}${object_name}"
        log_msg="-[${curr_time}] GET ${object_url}"
        echo $log_msg
        echo $log_msg >> $log_filename

        curl ${object_url} --head --output $log_filename &
    else
        log_msg="-[${curr_time}] Unknown action type"
        echo $log_msg
        echo $log_msg >> $log_filename
    fi
done < $trace_filename