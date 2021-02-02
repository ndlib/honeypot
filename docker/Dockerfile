FROM ruby:2.4

RUN apt-get update && apt-get install -y nodejs libgsf-1-dev libvips libvips-dev libvips-tools --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Configuration
ENV APP_DIR /honeypot
ENV TZ America/Indiana/Indianapolis
ENV RAILS_ENV development
ENV SECRET_KEY_BASE 033d9b408924e30217d91ee85af577135dc87ae34b050dd23606e5311f287aa8fc8615f8ca26cd5578f30de03fdb361085362eec873f13021f4956036e5922fc

# set timezone
RUN ln -s /usr/share/zoneinfo/$TZ localtime

# configure app directory and add deps.
RUN mkdir $APP_DIR
WORKDIR $APP_DIR
COPY ./Gemfile $APP_DIR
COPY ./Gemfile.lock $APP_DIR
RUN bundle install
COPY . $APP_DIR

VOLUME $APP_DIR/public

# Add a script to be executed every time the container starts.
COPY docker/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
