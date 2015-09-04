#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

docker build -f DockerfileCompile -t bigm/nginx-compile .
docker run --rm -ti -v $DIR:/prj \
  -v /home/k2s/Dev/nginx/nginx-upstream-dyanmic-servers:/tmp/nginx-upstream-dyanmic-servers \
  bigm/nginx-compile \
  ${1:-/prj/examples/nginx-upstream-dyanmic-servers.sh}
