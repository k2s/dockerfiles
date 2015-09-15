#!/bin/bash

if [ -n "$XT_RUN" ]; then
  echo "run on start command: $XT_RUN"
  $XT_RUN
fi
