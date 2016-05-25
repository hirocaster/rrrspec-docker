#!/bin/sh

set -e

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker run -d --name rrrspec-mysql -v ${CONTAINER_DIR}/mysql/conf.d:/etc/mysql/conf.d rrrspec/mysql
docker run -d --name rrrspec-redis rrrspec/redis
docker run -d --name rrrspec-rsyncd rrrspec/rsyncd

sleep 10

RUN_OPTION="--link rrrspec-redis:redis --link rrrspec-mysql:mysql --link rrrspec-rsyncd:rsyncd"

docker run -d --name rrrspec-server -p 8080:8080 ${RUN_OPTION} rrrspec/rrrspec-server
docker run -d --name rrrspec-worker ${RUN_OPTION} rrrspec/rrrspec-worker

cat <<EOF
1. Launch client container
  host$ docker run -i -t ${RUN_OPTION} rrrspec/rrrspec-client /bin/bash
2. Run test
  container# rrrspec-client start
3. Show report page.
  access to web container (http://localhost:8080)
EOF
