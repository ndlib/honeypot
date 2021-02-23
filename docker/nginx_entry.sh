# Have to do this here to allow using localhost when deployed with ECS awsvpc
# Could not see a way to have nginx config read env
sed -i "s;\${RAILS_HOST};$RAILS_HOST;g" /etc/nginx/conf.d/default.conf
sed -i "s;\${RAILS_PORT};$RAILS_PORT;g" /etc/nginx/conf.d/default.conf
sed -i "s;\${RAILS_STATIC_DIR};$RAILS_STATIC_DIR;g" /etc/nginx/conf.d/default.conf
sed -i "s;\${IIP_HOST};$IIP_HOST;g" /etc/nginx/conf.d/default.conf
sed -i "s;\${IIP_PORT};$IIP_PORT;g" /etc/nginx/conf.d/default.conf

bash /project_root/wait-for-it.sh -t 120 --strict ${RAILS_HOST}:${RAILS_PORT}
bash /project_root/wait-for-it.sh -t 120 --strict ${IIP_HOST}:${IIP_PORT}

exec nginx -g 'daemon off;'
