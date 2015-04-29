#!/usr/bin/env bash

UPDATE_TOOLS=0
WITH_ADMIN_TOOLS=0
TMP_PATH=/tmp/_dockerbuild
CONTEXT_PATH=$1

if [ $1 -eq 1 ]; then
    UPDATE_TOOLS=1
    WITH_ADMIN_TOOLS=1
    CONTEXT_PATH=$2
fi
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# TODO check if $1 folder exists

# copy docker build context path to temporary location
if [ -d $TMP_PATH ]; then
    rm -rf $TMP_PATH/*
else
    mkdir $TMP_PATH
fi
cp -a $CONTEXT_PATH/* $TMP_PATH/

cd $TMP_PATH

if [ $WITH_ADMIN_TOOLS -eq 1 ]; then
    sed -i '/^FROM /aRUN /xt/tools/_install_admin_tools' Dockerfile
fi

if [ $UPDATE_TOOLS -eq 1 ]; then
    cp -a $DIR/base-deb/tools $TMP_PATH/tools
    sed -i '/^FROM /aCOPY tools /xt/tools' Dockerfile
fi

# build image
docker build -t bigm/$CONTEXT_PATH .

if [ $? -eq 0 ]; then
    # run shell in the new container
    echo "starting bash in bigm/$CONTEXT_PATH image ..."
    docker run --rm -ti -P bigm/$CONTEXT_PATH bash
fi