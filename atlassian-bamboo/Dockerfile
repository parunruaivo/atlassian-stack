FROM java:8

MAINTAINER "Parun Rua, Ivo"

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV BAMBOO_HOME     /var/atlassian/bamboo
ENV BAMBOO_INSTALL  /opt/atlassian/bamboo
ENV BAMBOO_VERSION  5.9.3

ARG user=bamboo
ARG group=bamboo
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} ${user}

RUN mkdir -p    "${BAMBOO_HOME}" \
    && mkdir -p "${BAMBOO_INSTALL}"
RUN curl -Ls                   "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz" | tar -xz --directory "${BAMBOO_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e                 "\nbamboo.home=BAMBOO_HOME" > "${BAMBOO_INSTALL}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties"

RUN chown -R  ${user} "${BAMBOO_HOME}" "${BAMBOO_INSTALL}"

USER ${user}

EXPOSE 8090

VOLUME ["/var/atlassian/bamboo", "/opt/atlassian/bamboo"]

WORKDIR /var/atlassian/bamboo

CMD ["/opt/atlassian/bamboo/bin/catalina.sh", "run"]
