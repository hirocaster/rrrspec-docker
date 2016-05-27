#!/bin/bash

set -e

usage_exit() {
        echo "Usage: $0 [-n]" 1>&2
        exit 1
}

while getopts nh OPT
do
    case $OPT in
        n)  NO_CACHE="--no-cache=true"
            ;;
        h)  usage_exit
            ;;
        \?)
            ;;
    esac
done

shift $((OPTIND - 1))

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker build -t rrrspec/redis ${CONTAINER_DIR}/redis
docker build -t rrrspec/mysql ${CONTAINER_DIR}/mysql
docker build -t rrrspec/rsyncd ${CONTAINER_DIR}/rsyncd
docker build ${NO_CACHE} -t rrrspec/rrrspec-base ${CONTAINER_DIR}/rrrspec-base
docker build ${NO_CACHE} -t rrrspec/rrrspec-server ${CONTAINER_DIR}/rrrspec-server
docker build ${NO_CACHE} -t rrrspec/rrrspec-worker ${CONTAINER_DIR}/rrrspec-worker
docker build ${NO_CACHE} -t rrrspec/rrrspec-client ${CONTAINER_DIR}/rrrspec-client
