#!/bin/bash
user_id=$1
content_name=$2
content_size=$3

# info of ftp server
FTP_SERVER=$4
FTP_USERNAME="uftp"
FTP_PASSWORD="uftp"

echo "[post-content] user ${user_id} posting content ${content_name} to ${FTP_SERVER}"
# generate file content
dd if=/dev/urandom of="${content_name}" bs=1 count="${content_size}" status=progress

# use ftp to connect to ftp server and login
ftp -n $FTP_SERVER -P 7777 <<EOF
user $FTP_USERNAME $FTP_PASSWORD
put ${content_name}
bye
EOF

rm ${content_name}

