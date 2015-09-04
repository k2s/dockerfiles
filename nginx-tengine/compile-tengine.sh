#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

docker build -f DockerfileCompile -t bigm/nginx-tengine-compile .
docker run --rm -ti -v $DIR:/prj \
  bigm/nginx-tengine-compile \
  ${1:-/prj/examples/tengine.sh}
