#!/usr/bin/env bash

set -e

# execute all startup scripts
if [ -d /xt/startup ]; then
    run-parts -v /xt/startup
fi

# execute custom startup scripts
if [ -n $XT_USER_STARTUP ]; then
    if [ -d $XT_USER_STARTUP ]; then
        run-parts -v $XT_USER_STARTUP
    fi
fi

exec "$@"