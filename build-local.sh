#!/usr/bin/env bash

ORDER=(
    base-deb-minimal
    base-deb
    proxy-cache
    base-jdk7
    base-jdk8
    devtools
    cloudtools
    youtrack
    openfire
    rhc
    haproxy
)

#    rundeck
#    gocd-server
#    gocd-agent
#    rundeck
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
        docker build -t bigm/$fld $fld/
    else
        docker build -t bigm/$fld $fld/ > /dev/null
    fi
    if [ $? -ne 0 ]; then
    	echo "!!! error in image: $fld"
    	exit
    fi
done

echo "all images build"

#docker run --rm -ti -p 80:8080 bigm/youtrack

#docker run --rm -ti -p 5222:5222 -p 5223:5223 -p 5224:5224 -p 9090:9090 \
#    -v /tmp/openfire:/prj/data/openfire \
#    bigm/openfire

#docker run --rm -ti bigm/base-deb