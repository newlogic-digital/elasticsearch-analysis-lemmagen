ARG ES_VERSION=8.6.2
FROM docker.elastic.co/elasticsearch/elasticsearch:${ES_VERSION}

ARG ES_VERSION
COPY --chown=elasticsearch:elasticsearch ./target/releases/elasticsearch-analysis-lemmagen-${ES_VERSION}-plugin.zip /tmp/elasticsearch-analysis-lemmagen-${ES_VERSION}-plugin.zip

USER elasticsearch

RUN elasticsearch-plugin install file:///tmp/elasticsearch-analysis-lemmagen-${ES_VERSION}-plugin.zip

RUN mkdir -p /usr/share/elasticsearch/config/lemmagen && \
    cd /usr/share/elasticsearch/config/lemmagen && \
    curl -L https://github.com/vhyza/lemmagen-lexicons/raw/master/free/lexicons/en.lem -o en.lem
