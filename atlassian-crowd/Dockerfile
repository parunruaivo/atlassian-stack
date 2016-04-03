FROM java:8

MAINTAINER "Parun Rua, Ivo"

ENV CROWD_HOME /var/atlassian/crowd
ENV CROWD_INSTALL /opt/atlassian/crowd
ENV CROWD_VERSION 2.8.4

RUN groupadd -r crowd && useradd -r -g crowd crowd

RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends libtcnative-1 xmlstarlet

RUN mkdir -p                   "${CROWD_HOME}" \
    && chmod -R 700            "${CROWD_HOME}" \
    && chown crowd:crowd       "${CROWD_HOME}" \
    && mkdir -p                "${CROWD_INSTALL}"

RUN curl -Ls                   "https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-${CROWD_VERSION}.tar.gz" | tar -xz --directory "${CROWD_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e                 "\ncrowd.home=CROWD_HOME" >> "${CROWD_INSTALL}/crowd-webapp/WEB-INF/classes/crowd-init.properties"

USER crowd:crowd

EXPOSE 8085

VOLUME ["/var/atlassian/crowd", "/opt/atlassian/crowd"]

WORKDIR /var/atlassian/crowd

CMD ["/opt/atlassian/crowd/apache-tomcat/bin/catalina.sh", "run"]