# Grab base Alpine
FROM alpine:latest

# Set environment variables
ENV HOME /root
ENV SPLUNK_HOME /opt/splunk
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB.UTF-8

# ARGS

ARG DOWNLOAD_TARGET=https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.0&product=splunk&filename=splunk-8.0.0-1357bef0a7f6-Linux-x86_64.tgz&wget=true
ARG FS_DATA=/opt/splunkdata
ARG FS_APPS=/opt/splunk/etc/apps
ARG PORT_WEB_HTTP=8000
ARG PORT_API=8089
ARG PORT_TCPIN=9997
ARG PORT_SYSLOG=514

# ENVS based on ARGS (so you can configure either at build time or runtime)
ENV DOWNLOAD_TARGET $DOWNLOAD_TARGET
ENV SPLUNK_CLI_ARGS $SPLUNK_CLI_ARGS
ENV ADMIN_PASSWORD $ADMIN_PASSWORD
ENV FS_DATA $FS_DATA
ENV PORT_SYSLOG $PORT_SYSLOG
ENV PORT_WEB_HTTP $PORT_WEB_HTTP
ENV PORT_API $PORT_API
ENV PORT_TCPIN $PORT_TCPIN

# Add Splunk to env
ENV PATH=${SPLUNK_HOME}/bin:${PATH} HOME=$SPLUNK_HOME

# Add indexed data dir
RUN mkdir -p ${FS_DATA}

# Prepare startup script
WORKDIR ${SPLUNK_HOME}
COPY gosplunk.sh ./gosplunk.sh
RUN chmod +x ./gosplunk.sh

# Download Splunk and fix permissions
# Configure user nobody to match unRAID's settings
# Splunk expects users to have an entry in /etc/passwd, OpenShift doesn't generate this so we will create one. 
# See additional code in entrypoint script for writing the file.	
RUN FILE=`echo $DOWNLOAD_TARGET | sed -r 's/^.+(splunk-[^-]+).+$/\1/g'` && \
    wget -q -O $SPLUNK_HOME/$FILE.tar.gz $DOWNLOAD_TARGET && \ 
    chgrp -R 0 ${SPLUNK_HOME} && \
    chmod -R g=u ${SPLUNK_HOME} && \
    chmod -R 755 ${SPLUNK_HOME} && \
    chgrp -R 0 ${FS_DATA} && \
    chmod -R g=u ${FS_DATA} && \
    chmod -R 755 ${FS_DATA} && \
    chmod -R g=u /etc/passwd 

# Install dependancies 
# wget: for downloading Splunk and dependancies
# tar: for installing Splunk 
# alpine-sdk: provides linkers/builders required to run Splunk 
# ca-certificates: required to securely download modified glibc
# procps: required as Splunk uses ps with non-busybox arguments
RUN apk add --no-cache --virtual wget tar alpine-sdk ca-certificates procps

# Install custom glibc builder compatible with Splunk
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
    apk add glibc-2.29-r0.apk && \
    rm -f glicx-2.29-r0.apk

# Set up ports and volumes
VOLUME ["/apps", "${SPLUNK_HOME}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${PORT_API} ${PORT_TCPIN ${PORT_SYSLOG}
 
# Startup
WORKDIR ${SPLUNK_HOME}
ENTRYPOINT [ "./gosplunk.sh" ]
