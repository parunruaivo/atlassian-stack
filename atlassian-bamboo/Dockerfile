FROM java:8

MAINTAINER "Parun Rua, Ivo"

ENV BAMBOO_HOME     /var/atlassian/bamboo
ENV BAMBOO_INSTALL  /opt/atlassian/bamboo
ENV BAMBOO_VERSION  5.9.3

RUN groupadd -r bamboo && useradd -r -g bamboo bamboo

RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes --no-install-recommends libtcnative-1 xmlstarlet

RUN mkdir -p                   "${BAMBOO_HOME}" \
    && chmod -R 700            "${BAMBOO_HOME}" \
    && chown bamboo:bamboo     "${BAMBOO_HOME}" \
    && mkdir -p                "${BAMBOO_INSTALL}"

RUN curl -Ls                   "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz" | tar -xz --directory "${BAMBOO_INSTALL}" --strip-components=1 --no-same-owner \
    && sed --in-place          "s/java version/openjdk version/g" "${BAMBOO_INSTALL}/bin/check-java.sh" \
    && echo -e                 "\nbamboo.home=BAMBOO_HOME" >> "${BAMBOO_INSTALL}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties"

USER bamboo:bamboo

EXPOSE 8095

VOLUME ["/var/atlassian/bamboo", "/opt/atlassian/bamboo"]

WORKDIR /var/atlassian/bamboo

CMD ["/opt/atlassian/bamboo/bin/catalina.sh", "run"]
