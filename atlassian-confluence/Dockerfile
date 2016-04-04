FROM java:8

MAINTAINER "Parun Rua, Ivo"

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV CONF_HOME     /var/atlassian/confluence
ENV CONF_INSTALL  /opt/atlassian/confluence
ENV CONF_VERSION  5.9.6

ARG user=confluence
ARG group=confluence
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} ${user}

RUN mkdir -p     "${CONF_HOME}" \
    && mkdir -p  "${CONF_INSTALL}"

RUN curl -Ls                   "http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONF_VERSION}.tar.gz" | tar xzf - --strip=1 -C "${CONF_INSTALL}" \
    && echo -e                 "\nconfluence.home=$CONF_HOME" > "${CONF_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties"

RUN sed -i 's/-Xms512m/-Xms128m/' "${CONF_INSTALL}/bin/setenv.sh" \
    && sed -i 's/-Xmx2048m/-Xmx512m/' "${CONF_INSTALL}/bin/setenv.sh" \
    && sed -i 's/_%T//' "${CONF_INSTALL}/bin/setenv.sh"

RUN chown -R ${user} "${CONF_HOME}" "${CONF_INSTALL}"

USER ${user}

EXPOSE 8090

VOLUME ["/var/atlassian/confluence"]

WORKDIR /var/atlassian/confluence

CMD ["/opt/atlassian/confluence/bin/catalina.sh", "run"]