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

RUN curl -Ls                           "http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONF_VERSION}.tar.gz" | tar -xz --directory "${CONF_INSTALL}" --strip-components=1 --no-same-owner \
    && echo -e                         "\nconfluence.home=$CONF_HOME" >> "${CONF_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties" \
    && xmlstarlet                      ed --inplace \
        --delete                       "Server/@debug" \
        --delete                       "Server/Service/Connector/@debug" \
        --delete                       "Server/Service/Connector/@useURIValidationHack" \
        --delete                       "Server/Service/Connector/@minProcessors" \
        --delete                       "Server/Service/Connector/@maxProcessors" \
        --delete                       "Server/Service/Engine/@debug" \
        --delete                       "Server/Service/Engine/Host/@debug" \
        --delete                       "Server/Service/Engine/Host/Context/@debug" \
                                       "${CONF_INSTALL}/conf/server.xml" \
    && touch -d "@0"                   "/opt/atlassian/confluence/conf/server.xml"

RUN chown -R ${user} "${CONF_HOME}" "${CONF_INSTALL}"

USER ${user}

EXPOSE 8085

VOLUME ["/var/atlassian/confluence"]

WORKDIR /var/atlassian/confluence

CMD ["/opt/atlassian/confluence/bin/catalina.sh", "run"]