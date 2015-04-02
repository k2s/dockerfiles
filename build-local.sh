#!/usr/bin/env bash

export ORDER=(
    base-deb
    cloudtools
    devtools
    haproxy
    rhc
    youtrack
    openfire
)

echo "build all docker images"
for fld in "${ORDER[@]}"
do
    echo "> start build of $fld"
    docker build -t bigm/$fld $fld/ > /dev/null
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