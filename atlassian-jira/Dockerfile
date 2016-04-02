FROM java:8

MAINTAINER "Parun Rua, Ivo"

ENV JIRA_HOME     /var/atlassian/jira
ENV JIRA_INSTALL  /opt/atlassian/jira
ENV JIRA_VERSION  7.1.2

RUN groupadd -r jira && useradd -r -g jira jira

RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends libtcnative-1 xmlstarlet

RUN mkdir -p                   "${JIRA_HOME}" \
    && chmod -R 700            "${JIRA_HOME}" \
    && chown jira:jira         "${JIRA_HOME}" \
    && mkdir -p                "${JIRA_INSTALL}"

RUN curl -Ls                   "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-core-${JIRA_VERSION}.tar.gz" | tar -xz --directory "${JIRA_INSTALL}" --strip-components=1 --no-same-owner \
    && touch -d "@0"           "/opt/atlassian/jira/conf/server.xml" \
    && sed --in-place          "s/java version/openjdk version/g" "${JIRA_INSTALL}/bin/check-java.sh" \
    && echo -e                 "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties"

USER jira:jira

EXPOSE 8080

VOLUME ["/var/atlassian/jira", "/opt/atlassian/jira"]

WORKDIR /var/atlassian/jira

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]