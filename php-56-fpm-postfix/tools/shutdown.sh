#!/bin/bash

if [ "$1" != "force" ]; then
  q=$(mailq | grep -c "^[A-Z0-9]")
  if [ $q -ne 0 ]; then
    echo "!!! mail queue is not empty ($q) will wait until all emails are sent"
  fi

  while [ $q -ne 0 ]; do
    sleep 10
  done
fi

/usr/local/bin/supervisorctl shutdown
