# Grab base Alpine
FROM splunk/splunk:latest

# Copy Default.yml file
COPY default.yml /tmp/defaults/default.yml

# ARGS
ARG FS_DATA=/opt/splunk/var
ARG FS_APPS=/opt/splunk/etc/apps

# ENVS based on ARGS (so you can configure either at build time or runtime)
ENV SPLUNK_START_ARGS $SPLUNK_START_ARGS
ENV SPLUNK_PASSWORD $SPLUNK_PASSWORD
ENV SPLUNK_LICENSE_URI $SPLUNK_LICENSE_URI
ENV SYSLOG_PORT $SYSLOG_PORT
ENV PORT_WEB_HTTP $PORT_WEB_HTTP
ENV SPLUNK_SVC_PORT $SPLUNK_SVC_PORT
ENV SPLUNK_S2S_PORT $SPLUNK_S2S_PORT

# Set up ports and volumes
VOLUME ["${FS_APPS}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${SPLUNK_SVC_PORT} ${SPLUNK_S2S_PORT} ${SYSLOG_PORT}
