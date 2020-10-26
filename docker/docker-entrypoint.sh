#!/bin/bash
set -e

echo "Start Rails Service"
exec bundle exec rails s -e $RAILS_RUN_ENV -b 0.0.0.0 -p 3019
