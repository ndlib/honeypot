FROM ruby:2.4

RUN apt-get update && apt-get install -y nodejs libgsf-1-dev libvips libvips-dev libvips-tools --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Configuration
ENV APP_DIR /honeypot
ENV TZ America/Indiana/Indianapolis

# set timezone
RUN ln -s /usr/share/zoneinfo/$TZ localtime

RUN mkdir $APP_DIR
WORKDIR $APP_DIR
COPY ./Gemfile $APP_DIR
COPY ./Gemfile.lock $APP_DIR
RUN bundle install
COPY . $APP_DIR

# Add a script to be executed every time the container starts.
COPY docker/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
EXPOSE 3019
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0","-p", "3019"]