FROM ruby:2.5.1-alpine3.7

ENV BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle \
    RAILS_ROOT=/web

RUN mkdir -p $RAILS_ROOT
RUN mkdir -p $BUNDLE_PATH

WORKDIR $RAILS_ROOT

RUN set -x \
  && apk upgrade --no-cache \
  && apk add --no-cache --virtual build-dependencies \
    less \
    tzdata \
    build-base \
    mysql-dev \
    nodejs\
    libxml2-dev \
    libxslt-dev \
  && gem install --no-document nokogiri \
    -- --use-system-libraries \
    --with-xml2-config=/usr/bin/xml2-config \
    --with-xslt-config=/usr/bin/xslt-config

ADD Gemfile $RAILS_ROOT/Gemfile
ADD Gemfile.lock $RAILS_ROOT/Gemfile.lock

RUN bundle install

RUN mkdir -p tmp/sockets