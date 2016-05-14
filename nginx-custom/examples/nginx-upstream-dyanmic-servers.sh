#!/usr/bin/env bash

if [ ! -f /tmp/nginx-upstream-dyanmic-servers ]; then
  cd /tmp
  #git clone https://github.com/GUI/nginx-upstream-dyanmic-servers.git
  git clone https://github.com/k2s/nginx-upstream-dyanmic-servers
fi

sed -i '/--with-mail_ssl_module/a--add-module=/tmp/nginx-upstream-dyanmic-servers \\' /nginx-${NGINX_VER}/debian/rules
cd /nginx-${NGINX_VER}
dpkg-buildpackage -b

cp -f /nginx-common*.deb /prj/
cp -f /nginx-full_*.deb /prj/
chmod 0777 /prj/*.deb