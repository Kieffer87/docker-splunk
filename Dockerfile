# Grab base Alpine
FROM splunk/splunk:latest

# Copy Default.yml file
COPY default.yml /tmp/defaults/default.yml

# ARGS
ARG FS_DATA=/opt/splunk/var
ARG FS_CONFIG=/opt/splunk/etc
ARG SPLUNK_PASSWORD=changeme2019
ARG SPLUNK_S2S_PORT=9997
ARG SPLUNK_SVC_PORT=8089
ARG PORT_WEB_HTTP=8000
ARG SYSLOG_PORT=1514
ARG SPLUNK_START_ARGS=--accept-license

# Will be added in future release https://github.com/splunk/docker-splunk/issues/251
#ARG SPLUNK_LICENSE_URI="Free"
#ENV SPLUNK_LICENSE_URI $SPLUNK_LICENSE_URI

# ENVS based on ARGS (so you can configure either at build time or runtime)
ENV SPLUNK_START_ARGS $SPLUNK_START_ARGS
ENV SPLUNK_PASSWORD $SPLUNK_PASSWORD
ENV SYSLOG_PORT $SYSLOG_PORT
ENV PORT_WEB_HTTP $PORT_WEB_HTTP
ENV SPLUNK_SVC_PORT $SPLUNK_SVC_PORT
ENV SPLUNK_S2S_PORT $SPLUNK_S2S_PORT

# Set up ports and volumes
VOLUME ["${FS_CONFIG}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${SPLUNK_SVC_PORT} ${SPLUNK_S2S_PORT} ${SYSLOG_PORT}
