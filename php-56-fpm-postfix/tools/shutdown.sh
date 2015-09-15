#!/bin/bash

if [ "$1" != "force" ]; then
  # q=$(mailq | grep -c "^[A-Z0-9]")
  q=$(mailq | head -1)
  if [ "$q" != "Mail queue is empty" ]; then
    echo "!!! mail queue is not empty will wait until all emails are sent"
  fi

  while [ "$q" != "Mail queue is empty" ]; do
    sleep 5
    q=$(mailq | head -1)
  done
fi

/usr/local/bin/supervisorctl shutdown
