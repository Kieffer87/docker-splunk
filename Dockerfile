# Grab lasted version of splunk
FROM splunk/splunk:latest

# Copy Default.yml file
COPY default.yml /tmp/defaults/default.yml

# These should match the target directories set in Unraid
ARG FS_DATA=/opt/splunk/var
ARG FS_CONFIG=/opt/splunk/etc

# Will be added in future release https://github.com/splunk/docker-splunk/issues/251
ENV SPLUNK_LICENSE_URI $SPLUNK_LICENSE_URI

# ENVS based on Unraid variables
ENV SPLUNK_START_ARGS $SPLUNK_START_ARGS
ENV SPLUNK_PASSWORD $SPLUNK_PASSWORD
ENV SYSLOG_PORT $SYSLOG_PORT
ENV PORT_WEB_HTTP $PORT_WEB_HTTP
ENV SPLUNK_SVC_PORT $SPLUNK_SVC_PORT
ENV SPLUNK_S2S_PORT $SPLUNK_S2S_PORT

# Set up ports and volumes
VOLUME ["${FS_CONFIG}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${SPLUNK_SVC_PORT} ${SPLUNK_S2S_PORT} ${SYSLOG_PORT}
