FROM ubuntu:18.04

LABEL maintainer="ninckblokje"

EXPOSE 20-21
EXPOSE 65500-65515

RUN mkdir -p /app/ftp && mkdir -p /var/run/vsftpd/empty

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y vsftpd uuid

COPY container.sh /root/container.sh
RUN chmod u+x /root/container.sh

COPY vsftpd.conf /etc/vsftpd.conf
COPY users.list /root

CMD ["/bin/bash", "-c", "/root/container.sh"]