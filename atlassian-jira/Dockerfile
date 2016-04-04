FROM java:8

MAINTAINER "Parun Rua, Ivo"

RUN apt-get update && apt-get install -y wget git curl zip libtcnative-1 xmlstarlet && rm -rf /var/lib/apt/lists/*

ENV JIRA_HOME     /var/atlassian/jira
ENV JIRA_INSTALL  /opt/atlassian/jira
ENV JIRA_VERSION  7.1.2

ARG user=jira
ARG group=jira
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} ${user}

RUN mkdir -p    "${JIRA_HOME}" \
    && mkdir -p "${JIRA_INSTALL}"

RUN curl -Ls                    "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-core-${JIRA_VERSION}.tar.gz" | tar xzf - --strip=1 -C "${JIRA_INSTALL}" \
     && sed --in-place          "s/java version/openjdk version/g" "${JIRA_INSTALL}/bin/check-java.sh" \
     && echo -e                 "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties"

RUN chown -R ${user} "${JIRA_HOME}" "${JIRA_INSTALL}"

USER ${user}

EXPOSE 8080

VOLUME ["/var/atlassian/jira", "/opt/atlassian/jira"]

WORKDIR /var/atlassian/jira

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]