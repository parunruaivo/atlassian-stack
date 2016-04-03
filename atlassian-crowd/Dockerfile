FROM java:8

MAINTAINER "Parun Rua, Ivo"

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV CROWD_HOME /var/atlassian/crowd
ENV CROWD_INSTALL /opt/atlassian/crowd
ENV CROWD_VERSION 2.8.4

ARG user=crowd
ARG group=crowd
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} ${user}

RUN mkdir -p    "${CROWD_HOME}" \
    && mkdir -p "${CROWD_INSTALL}"

RUN curl -Ls      "https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-${CROWD_VERSION}.tar.gz" | tar -xz --directory "${CROWD_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e    "\ncrowd.home=CROWD_HOME" >> "${CROWD_INSTALL}/crowd-webapp/WEB-INF/classes/crowd-init.properties"

RUN chown -R ${user} "${CROWD_HOME}" "${CROWD_INSTALL}"

USER ${user}

EXPOSE 8095

VOLUME ["/var/atlassian/crowd", "/opt/atlassian/crowd"]

WORKDIR /var/atlassian/crowd

CMD ["/opt/atlassian/crowd/apache-tomcat/bin/catalina.sh", "run"]