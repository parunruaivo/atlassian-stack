FROM postgres:9.5

MAINTAINER "Parun Rua, Ivo"

COPY setup-jira-db.sh /docker-entrypoint-initdb.d/setup-jira-db.sh
COPY setup-crowd-db.sh /docker-entrypoint-initdb.d/setup-crowd-db.sh
COPY setup-confluence-db.sh /docker-entrypoint-initdb.d/setup-confluence-db.sh
COPY setup-bamboo-db.sh /docker-entrypoint-initdb.d/setup-bamboo-db.sh

VOLUME ["/var/lib/postgresql"]