FROM opcycle/openjdk:11

ARG SOLR_VERSION="8.10.0"

ENV SOLR_USER="solr" \
    SOLR_UID="8983" \
    SOLR_GROUP="solr" \
    SOLR_GID="8983" \
    SOLR_DIST_URL="https://www.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"

RUN set -ex; \
  groupadd -r --gid "$SOLR_GID" "$SOLR_GROUP"; \
  useradd -r --uid "$SOLR_UID" --gid "$SOLR_GID" "$SOLR_USER"

RUN wget -t 10 --retry-connrefused -nv $SOLR_DIST_URL -O "/opt/solr-$SOLR_VERSION.tgz"
RUN tar -C /opt --extract --file "/opt/solr-$SOLR_VERSION.tgz"; \
  (cd /opt; mv "solr-$SOLR_VERSION" solr); \
  rm "/opt/solr-$SOLR_VERSION.tgz";

VOLUME /var/solr
EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER