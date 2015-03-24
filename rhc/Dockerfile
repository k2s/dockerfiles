# https://registry.hub.docker.com/_/ruby/
FROM ruby:latest

RUN apt-get update \
    && apt-get -y install ruby-full rubygems git-core \
    && rm -rf /var/lib/apt/lists/*

RUN gem install rhc

RUN apt-get update \
    && apt-get -y install less \
    && rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
