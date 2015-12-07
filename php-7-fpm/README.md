# PHP-56-FPM

## Start

This will start php-fpm listening on port 9000:
  
    docker run --rm -ti --name php-fpm \
        -v <project files>:/var/www/<project> \
        bigm/php-56-fpm
        

## Customize configuration

* customized php.ini
    * /usr/local/etc/php/php.ini
    * /usr/local/etc/php/conf.d 
* customized php-fpm.conf
    * /usr/local/etc/php-fpm.conf
    * /usr/local/etc/fpm.d
* mount host directory to /usr/local/etc    

## Environment variables

* PHP_CONF_VERSION: will use php.ini-${PHP_CONF_VERSION} as initial PHP configuration, default=production 
* PHP_ENABLE_XDEBUG: will enable xdebug extension, default=0
* PHP_TIMEZONE: set timezone, default=Europe/London 

### Enable xdebug on image start

Pass environment variable ```-e PHP_ENABLE_XDEBUG=1```

    docker run --rm -ti -e PHP_ENABLE_XDEBUG=1 bigm/php-56-fpm
    
## Reload config

    pkill -o -USR2 php-fpm

##TODO

session.save_handler=memcached
session.save_path=localhost:11211?persistent=1&weight=1&timeout=1&retry_interval=15


* remove HHVM
* session 
** https://github.com/tarantool/tarantool-php/issues
** http://nitschinger.at/How-to-store-PHP-sessions-in-Couchbase
** http://redis.io/documentation + https://github.com/phpredis/phpredis
** http://www.caiapps.com/memcached-for-load-balancing-sessions/
** https://github.com/cballou/MongoSession
** https://github.com/nicktacular/php-mongo-session
** https://github.com/sdolgy/php-cassandra-sessions

## kumofs - https://github.com/etolabo/kumofs
#ENV KUMOFS_VERSION=3.0.8
#RUN /xt/tools/_apt_install g++ libtool automake msgpack ruby ragel libmsgpack-dev libtokyocabinet-dev \
#	&& /xt/tools/_download /tmp/kumofs.tar.gz https://github.com/etolabo/kumofs/archive/kumofs-${KUMOFS_VERSION}.tar.gz \
#	&& cd /tmp && tar xf memcache.tgz \
#	&& cd /tmp/kumofs-kumofs-${KUMOFS_VERSION} \
#	&& ./configure \
#	&& make \
#	&& make install


#RUN /xt/tools/_apt_install libxrender-dev libfontconfig1 \
#	&& /xt/tools/_download /tmp/wkhtml.tgz <???> \
#	&& cd /opt && tar xf /tmp/wkhtml.tgz