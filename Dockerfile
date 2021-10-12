FROM opcycle/openjdk:11

ARG SOLR_VERSION="8.2.0"

ENV SOLR_PORT="8080" \
    SOLR_USER="solr" \
    SOLR_UID="8983" \
    SOLR_GROUP="solr" \
    SOLR_GID="8983" \
    SOLR_DIST_URL="https://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"

RUN groupadd -r --gid "$SOLR_GID" "$SOLR_GROUP"
RUN useradd -r --uid "$SOLR_UID" --gid "$SOLR_GID" "$SOLR_USER"
RUN curl $SOLR_DIST_URL --output /opt/solr-$SOLR_VERSION.tgz; \
    tar -C /opt --extract --file /opt/solr-$SOLR_VERSION.tgz; \
    (cd /opt; mv "solr-$SOLR_VERSION" solr); \
    rm /opt/solr-$SOLR_VERSION.tgz; \
    rm -rf /opt/solr/*.txt /opt/solr/example /opt/solr/docs /opt/solr/licenses /opt/solr/bin; \
    mkdir -p /opt/solr/server/work; \
    mkdir -p /opt/solr/data/cores; \
    chown solr:solr -R /opt/solr

COPY solr /opt/solr
COPY solr.xml /opt/solr/data
RUN chmod +x /opt/solr/solr

VOLUME /opt/solr/data/cores
WORKDIR /opt/solr
USER $SOLR_USER

ENTRYPOINT ["/opt/solr/solr"]