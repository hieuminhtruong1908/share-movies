ARG RUBY_VERSION=3.2.2

FROM ruby:${RUBY_VERSION}-slim-buster

WORKDIR /app

COPY . .

RUN apt-get update && \
    apt-get install build-essential -y --no-install-recommends \
    vim \
    git \
    gnupg2 \
    curl \
    wget \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    libmariadb-dev \
    libsqlite3-dev
    
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt-get -y install nodejs

ENV BUNDLER_PATH=/bundle BUNDLE_BIN=/bundle/bin GEM_HOME=/bundle

ENV PATH="${BUNDLE_BIN}:${PATH}"

ARG BUNDLER_VERSION=2.4.18

RUN gem install bundler:${BUNDLER_VERSION}

RUN bundle install --path=${BUNDLER_PATH}

COPY docker/app/*.sh /scripts/

RUN chmod a+x /scripts/*.sh
