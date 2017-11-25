FROM alpine:3.6
MAINTAINER Jon de Sarre <me@iamjon.net>

RUN \
    apk update && \
    apk add openjdk8-jre dpkg tar curl mongodb

RUN \
    mkdir -p /opt/unifi-app /opt/unifi-var/data /opt/unifi-var/log /opt/unifi-var/run /opt/tmp

ENV UNIFI_VERSION=5.6.22
ENV UNIFI_URL=http://dl.ubnt.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb

RUN \
    curl ${UNIFI_URL} --output /opt/tmp/unifi.deb && \
    dpkg-deb -x /opt/tmp/unifi.deb /opt/tmp && \
    mv /opt/tmp/usr/lib/unifi/* /opt/unifi-app && \
    ln -s /opt/unifi-var/data /opt/unifi-app/data && \
    ln -s /opt/unifi-var/log /opt/unifi-app/logs && \
    ln -s /opt/unifi-var/run /opt/unifi-app/run && \
    ln -s /usr/bin/mongod /opt/unifi-app/bin && \
    rm -r /opt/tmp

ADD entrypoint.sh /opt

# Expose the ports.  These are the product defaults
EXPOSE 8081 
EXPOSE 8080
EXPOSE 8443 
EXPOSE 8880
EXPOSE 8843

VOLUME [ "/opt/unifi-var" ]

ENTRYPOINT [ "/opt/entrypoint.sh" ]