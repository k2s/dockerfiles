#!/usr/bin/env bash

set -x

# TODO monito solution https://www.brianchristner.io/how-to-setup-docker-monitoring/
# TODO wordpress

ORDER=(
  base-deb-minimal
  base-deb
  base-deb-tools
  proxy-cache
  mailhub
  devtools
  admintools
  cloudtools
  haproxy
#  monitor-nagios
#  puppetserver
  base-jdk7
  base-jdk8
  youtrack
  openfire
  nfs
#  rhc
#  rundeck
  rsync
#  prj-tmp
#  runtime
#  runtime-nodejs
  shell
  sphinxsearch
  php-56-fpm
  nginx
  mongodb
)

#    gocd-server
#    gocd-agent
DEBUG=0

if [ ! -z $1 ]; then
  DEBUG=0
  ORDER=()
  ORDER=$@
fi

export ORDER

echo "build all docker images"
for fld in "${ORDER[@]}"
do
  echo "> start build of $fld"
  if [ $DEBUG ]; then
    # --no-cache
    docker build -t bigm/$fld $fld/
  else
    docker build -t bigm/$fld $fld/ > /dev/null
  fi
  if [ $? -ne 0 ]; then
    echo "!!! error in image: $fld"
    exit
  fi
done

### https://github.com/docker-in-practice/docker-image-graph
#docker run --rm -v /var/run/docker.sock:/var/run/docker.sock centurylink/image-graph > /tmp/docker_images.png

echo "all images build, see /tmp/docker_images.png"

#docker run --name nagios -v /tmp/nagios3:/etc/nagios3 --rm -ti -p 80:80 bigm/monitor-nagios

#docker run --rm -ti -p 5222:5222 -p 5223:5223 -p 5224:5224 -p 9090:9090 \
#    -v /tmp/openfire:/prj/data/openfire \
#    bigm/openfire

#docker run --rm -ti bigm/base-deb