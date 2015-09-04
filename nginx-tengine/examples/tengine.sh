#!/usr/bin/env bash

TENGINE_VER=2.1.1
/xt/tools/_download /tmp/tengine.tar.gz \
  http://tengine.taobao.org/download/tengine-${TENGINE_VER}.tar.gz \
  357ec313735bce0b75fedd4662f6208c \

mkdir /build
tar xvzf /tmp/tengine.tar.gz -C /build --strip-components=1
rm -f /tmp/tengine.tar.gz
cd /build
mv packages/debian .

DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -uc -b

cp -f /tengine_2.1.0-1_amd64.deb /prj/tengine_2.1.1-1_amd64.deb
chmod 777 /prj/tengine_2.1.1-1_amd64.deb