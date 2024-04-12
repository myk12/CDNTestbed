FROM ubuntu

RUN apt-get update
RUN apt-get install -y vim ftp vsftpd curl

COPY boot-start.sh /usr/local/bin/launch-action.sh
COPY post-content.sh /root/post-content.sh

ENTRYPOINT ["/usr/local/bin/launch-action.sh"]
