# Grab base Alpine
FROM splunk/splunk:latest

# Copy Default.yml file
COPY default.yml /tmp/defaults/default.yml

# Set environment variables
ENV SPLUNK_DEFAULTS_URL /tmp/defaults/default.yml

# ARGS
ARG FS_DATA=/opt/splunk/var
ARG FS_APPS=/opt/splunk/etc/apps

# ENVS based on ARGS (so you can configure either at build time or runtime)
ENV SPLUNK_START_ARGS $SPLUNK_START_ARGS
ENV SPLUNK_PASSWORD $SPLUNK_PASSWORD

ENV PORT_SYSLOG $PORT_SYSLOG
ENV PORT_WEB_HTTP $PORT_WEB_HTTP
ENV PORT_API $PORT_API
ENV PORT_TCPIN $PORT_TCPIN

# Set up ports and volumes
VOLUME ["${FS_APPS}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${PORT_API} ${PORT_TCPIN} ${PORT_SYSLOG}
