#!/bin/bash
set -e

echo "Modify config file for secrets"
sed -i 's/<%= ENV["SECRET_KEY_BASE"] %>/'"$SECRET_KEY_BASE"'/g' "$APP_DIR/config/secrets.yml"

echo "Start Rails Service"
exec bundle exec rails s -e $RAILS_RUN_ENV -b 0.0.0.0 -p 3019
