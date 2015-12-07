#!/usr/bin/env bash
# based on https://github.com/docker-library/php/blob/master/5.6/fpm/Dockerfile

set -x
/xt/tools/_download  php.tar.bz2 "http://php.net/get/php-$PHP_VERSION.tar.bz2/from/this/mirror"
/xt/tools/_download php.tar.bz2.asc "http://php.net/get/php-$PHP_VERSION.tar.bz2.asc/from/this/mirror"
gpg --verify php.tar.bz2.asc
mkdir -p /usr/src/php
tar -xof php.tar.bz2 -C /usr/src/php --strip-components=1
rm php.tar.bz2.asc
cd /usr/src/php
./configure \
	--with-config-file-path="$PHP_INI_DIR" \
	--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
	$PHP_EXTRA_CONFIGURE_ARGS \
	--disable-cgi \
	--enable-mysqlnd \
	--with-curl \
	--with-openssl \
	--with-pcre \
	--with-readline \
	--with-recode \
	--with-zlib

make -j"$(nproc)"
make install
{ find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; }
apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps

make clean

cp /usr/src/php/php.ini-* /usr/local/etc/php/
rm -fr /usr/src/php
