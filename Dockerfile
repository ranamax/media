FROM       centos:centos7

# Fix broken link for /var/lock
RUN mkdir -p /run/lock/subsys

# Update RPM Packages
RUN yum -y update; yum clean all
RUN yum -y install initscripts; yum clean all
RUN rpm -Uvh https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver-1.14.1.5488-cc260c476.x86_64.rpm; echo 'avoiding error'
RUN mkdir /config && \
    mkdir /data && \
    chown plex:plex /config && \
    chown plex:plex /data
VOLUME ["/config"]
VOLUME ["/data"]

ADD PlexMediaServer /etc/sysconfig/PlexMediaServer
ADD start.sh /start.sh

EXPOSE 32400

CMD ["/bin/bash", "/start.sh"]
