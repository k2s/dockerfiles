#!/usr/bin/env bash

source ./build-local.sh $@

echo "push images to Docker registry"

for fld in "${ORDER[@]}"
do
    echo "> push $fld"
    docker tag -f bigm/$fld:latest quay.io/bigm/$fld:latest
    docker push quay.io/bigm/$fld:latest
    if [ $? -ne 0 ]; then
    	echo "!!! error in image: $fld"
    	exit
    fi
done

echo "all images pushed"