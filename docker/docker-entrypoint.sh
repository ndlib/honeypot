#!/bin/bash
set -e

echo "Remove server PID if exists"
rm -f "$APP_DIR/tmp/pids/server.pid"

echo "Copy secrets template file"
cp "$APP_DIR/config/secrets.yml.template" "$APP_DIR/config/secrets.yml"

echo "Modify config file for secrets"
sed -i 's/${SECRET_KEY_BASE}/'"$SECRET_KEY_BASE"'/g' "$APP_DIR/config/secrets.yml"

echo "Start Rails Service"
exec bundle exec rails s -e $RAILS_ENV -b 0.0.0.0 -p 3019
