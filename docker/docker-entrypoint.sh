#!/bin/bash
set -e

echo "Start Rails Service"
cd $APP_DIR
pwd
ls -la
exec rails s -p 3019 -b '0.0.0.0'
# exec "$@"