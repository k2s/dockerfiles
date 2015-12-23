#!/usr/bin/env bash

set -e

if [ -z $XT_DISABLE_STARTUP ]; then
    # mix custom startup scripts with image startup scripts
    if [ -n $XT_PRJ_STARTUP ]; then
        if [ -d $XT_PRJ_STARTUP ]; then
            cp -a $XT_PRJ_STARTUP/. /xt/startup/
        fi
    fi

    # execute all startup scripts
    if [ -d /xt/startup ]; then
        run-parts -v /xt/startup
    fi
else
    echo "skipping /xt/startup because \$XT_DISABLE_STARTUP is defined"
fi

exec "$@"
