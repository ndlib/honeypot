FROM ndlib/honeypot:base-v1
MAINTAINER Justin Gondron <jgondron@nd.edu>

COPY . /usr/src/app

COPY config/docker/* /usr/src/app/config/

EXPOSE 3019
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3019"]

# Rebuild using the Dockerfile
# docker build --no-cache -t ndlib/honeypot .

# Start a shell
# docker run --rm -t -i ndlib/honeypot /bin/bash

# Start rails daemonized
# docker run -p 3019:3019 -d --name honeypot ndlib/honeypot

# Stop the running containter
# docker stop honeypot

# Remove the container
# docker rm honeypot
