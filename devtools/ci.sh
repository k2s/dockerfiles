#!/usr/bin/env bash

### fail on each failed exit code
set -e

[ -d /prj/ci ] || mkdir -p /prj/ci

if [ -n "$DOWNLOAD_RSYNC" ]; then
  # TODO
  echo "populate /prj/ci folder from rsync"
fi

if [ -n "$DOWNLOAD_URL" ]; then
  # TODO
  echo "populate /prj/ci folder from zip file stored on url"
fi

if [ ! -f /prj/ci/build.sh ]; then
  echo "nothing to do because /prj/ci/build.sh was not found"
  exit 1
fi

/prj/ci/build.sh

if [ -d /prj/release ]; then
  if [ -n "$UPLOAD_RSYNC" ]; then
    echo "uploading release to rsync target"
    rsync -a --delete /prj/release $UPLOAD_RSYNC
    echo "upload to rsync target FINISHED"
  fi
else
  echo "build failed because /prj/release folder was not found"
  exit 2
fi