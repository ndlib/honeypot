FROM ruby:2.2
MAINTAINER Justin Gondron <jgondron@nd.edu>

RUN apt-get update && apt-get install -y libgsf-1-dev libvips libvips-dev libvips-tools --no-install-recommends && rm -rf /var/lib/apt/lists/*
# need libtiff5, libjpeg-turbo8?

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install gems
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

COPY config/docker/* /usr/src/app/config/

EXPOSE 3019
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3019"]


# Rebuild using the Dockerfile
# docker build --rm -t nd/honeypot:v1 .

# Start a shell
# docker run --rm -t -i nd/honeypot:v1 /bin/bash

# Start rails daemonized
# docker run -p 3019:3019 -d --name honeypot nd/honeypot:v1

# Stop the running containter
# docker stop honeypot

# Remove the container
# docker rm honeypot
