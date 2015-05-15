#!/usr/bin/env bash

# execute all startup scripts
if [ -d /prj/startup ]; then
  run-parts -v /prj/startup
fi

if [ -z "$@" ]; then
  echo "starting apache"
  exec /usr/local/bin/apache2-foreground
else
  echo "starting alternative command"
  exec "$@"
fi
