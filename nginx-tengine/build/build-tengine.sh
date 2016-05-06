#!/usr/bin/env bash

TENGINE_VER=$1

case "$TENGINE_VER" in
    "2.1.1")
        chksum=357ec313735bce0b75fedd4662f6208c
        ;;
    "2.1.2")
        chksum=7f898a0dbb5162ff1eb19aeb9d53bec3
        ;;
    *)
        echo "not supported version: $TENGINE_VER"
        exit 1
esac
/xt/tools/_download /tmp/tengine.tar.gz \
  http://tengine.taobao.org/download/tengine-${TENGINE_VER}.tar.gz \
  $chksum \

mkdir /build
tar xvzf /tmp/tengine.tar.gz -C /build --strip-components=1
rm -f /tmp/tengine.tar.gz
cd /build
mv packages/debian .

# fix non-resolved DNS entries
patch -d /build/src/http < ngx_http_upstream-2.1.1.patch

# build
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -uc -b

cp -f /tengine_2.1.0-1_amd64.deb /prj/tengine_${TENGINE_VER}-1_amd64.deb
chmod 777 /prj/tengine_${TENGINE_VER}-1_amd64.deb
