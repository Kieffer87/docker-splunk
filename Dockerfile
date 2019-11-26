# Grab base Alpine
FROM splunk/splunk:latest

# Set environment variables
ENV SPLUNK_HOME /opt/splunk

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

USER root
RUN mkdir -p ${FS_DATA}
RUN chown splunk:splunk ${FS_DATA}

# Set up ports and volumes
VOLUME ["${FS_APPS}", "${SPLUNK_HOME}", "${FS_DATA}"]
EXPOSE ${PORT_WEB_HTTP} ${PORT_API} ${PORT_TCPIN} ${PORT_SYSLOG}
