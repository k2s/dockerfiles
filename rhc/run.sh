#!/usr/bin/env bash

echo "preparing ssh ..."
cp -r /private /root/.ssh
chown -R root:root /root/.ssh

exec "$@"
