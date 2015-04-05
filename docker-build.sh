#!/usr/bin/env bash

UPDATE_TOOLS=1
WITH_ADMIN_TOOLS=1
TMP_DOCKERFILE=tmpDockerfile

cd $1

cp Dockerfile $TMP_DOCKERFILE

if [ $WITH_ADMIN_TOOLS -eq 1 ]; then
    sed -i '/^FROM /aRUN /xt/tools/_install_admin_tools' $TMP_DOCKERFILE
fi

if [ $UPDATE_TOOLS -eq 1 ]; then
    cp -r ../base-deb/tools ./.tools
    sed -i '/^FROM /aCOPY .tools /xt/tools' $TMP_DOCKERFILE
fi

docker build -t bigm/$1 - < ./$TMP_DOCKERFILE

#rm -fr .tools
#rm -f .Dockerfile
