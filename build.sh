#!/bin/sh

set -e

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker build -t rrrspec/redis ${CONTAINER_DIR}/redis
docker build -t rrrspec/mysql ${CONTAINER_DIR}/mysql
docker build -t rrrspec/rsyncd ${CONTAINER_DIR}/rsyncd
docker build -t rrrspec/rrrspec-base ${CONTAINER_DIR}/rrrspec-base
docker build -t rrrspec/rrrspec-server ${CONTAINER_DIR}/rrrspec-server
docker build -t rrrspec/rrrspec-worker ${CONTAINER_DIR}/rrrspec-worker
docker build -t rrrspec/rrrspec-client ${CONTAINER_DIR}/rrrspec-client
