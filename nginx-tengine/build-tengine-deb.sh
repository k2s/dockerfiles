#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

version=${1:-2.1.2}

docker build -f DockerfileCompile -t bigm/nginx-tengine-compile .
docker run --rm -ti -v $DIR/build:/prj \
  bigm/nginx-tengine-compile \
  /prj/build-tengine.sh $version
