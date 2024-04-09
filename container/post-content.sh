#!/bin/bash

user_id=$1
content_name=$2
content_size=$3

echo "[post-content] user ${user_id} posting content ${content_name}"

# generate file content
dd if=/dev/urandom of="${content_name}" bs=1 count="${content_size}" status=progress

# push file to root
