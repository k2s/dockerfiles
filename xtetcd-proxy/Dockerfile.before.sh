#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cp /etc/ssl/certs/ca-certificates.crt .
cd $DIR/src
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o $DIR/xtetcd-proxy .
cd $DIR

