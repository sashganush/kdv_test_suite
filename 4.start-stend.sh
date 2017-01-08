export SITE_PORT=8000

docker run -d \
    -p ":11211"  \
    --name ${SITE}-memcached \
    -t memcached:latest

docker run -d \
    -p ":80"  \
    -p ":25"  \
    --name ${SITE}-maildev \
    -t djfarrelly/maildev


docker run -d \
    -p ":5432"  \
    --name ${SITE}-pmaster \
    -e POSTGRES_USER=test \
    -e POSTGRES_PASSWORD=test \
    -v ${SITEROOT}/pgdata/${SITE}-master:/var/lib/postgresql/data \
    -t postgres:latest


#cat php-fpm-custom/Dockerfile | docker build - -t php-fpm-custom
#docker run -d \
#    -v ${SITEROOT}/nginx/htdocs:/home/nginx/htdocs \
#    --name=${SITE}-php \
#    --link ${SITE}-pmaster:${SITE}-pmaster \
#    -t php-fpm-custom

docker run -d \
    -v ${SITEROOT}/nginx/htdocs:/home/nginx/htdocs \
    --name=${SITE}-php \
    --link ${SITE}-pmaster:${SITE}-pmaster \
    -t php:7-fpm


mkdir ${SITEROOT}
mkdir ${SITEROOT}/nginx 
touch ${SITEROOT}/nginx/default.conf

docker run  -d \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    -v /home/sash/kdv_test_suite/tmpl/mysite.template:/etc/nginx/conf.d/mysite.template \
    -v ${SITEROOT}/nginx/default.conf:/etc/nginx/conf.d/default.conf:rw \
    -v ${SITEROOT}/nginx/htdocs:/home/nginx/htdocs \
    -v ${SITEROOT}/nginx/logs:/home/nginx/logs:rw \
    --name ${SITE}-nginx \
    -e VIRTUAL_HOST=${SITE} \
    -e VIRTUAL_PORT=${SITE_PORT} \
    -e NGINX_HOST=${SITE} \
    -e NGINX_PORT=${SITE_PORT} \
    -e DOLLAR='$' \
    --expose ${SITE_PORT} \
    --link ${SITE}-php:${SITE}-php \
    -p ${SITE_PORT} \
    -t nginx  \
    /bin/bash -c "envsubst  < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && cp /etc/nginx/conf.d/default.conf /tmp/default.conf && cat /tmp/default.conf  && nginx -g 'daemon off;'"




echo "<?php phpinfo();" > ${SITEROOT}/nginx/htdocs/info.php

echo "${SITE} works now!" > ${SITEROOT}/nginx/htdocs/site.php
