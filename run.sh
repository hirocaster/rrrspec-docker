#!/bin/sh

set -e

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker run -d --name rrrspec-mysql -v ${CONTAINER_DIR}/mysql/conf.d:/etc/mysql/conf.d rrrspec/mysql
docker run -d --name rrrspec-redis rrrspec/redis
docker run -d --name rrrspec-rsyncd rrrspec/rsyncd

sleep 10

RUN_OPTION="--link rrrspec-redis:redis --link rrrspec-mysql:mysql --link rrrspec-rsyncd:rsyncd"

docker run -d --name rrrspec-server ${RUN_OPTION} rrrspec/rrrspec-server
docker run -d --name rrrspec-web -p 8080:8080 ${RUN_OPTION} rrrspec/rrrspec-web
