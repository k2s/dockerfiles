#!/usr/bin/env bash

set -e

# execute all startup scripts
if [ -d /prj/startup ]; then
    run-parts -v /prj/startup
fi

exec "$@"