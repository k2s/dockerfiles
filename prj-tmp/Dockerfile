FROM php:5.6-apache

RUN a2enmod rewrite && a2enmod macro && a2enmod headers && a2enmod include

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd zip

RUN docker-php-ext-install mbstring pdo_mysql
RUN pecl install xdebug
RUN echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/ext-xdebug.ini \
  && echo "xdebug.remote_enable = on" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
  && echo "xdebug.remote_connect_back = on" >> /usr/local/etc/php/conf.d/ext-xdebug.ini \
  && echo 'xdebug.idekey = "PHPSTORM"' >> /usr/local/etc/php/conf.d/ext-xdebug.ini

RUN yes "" | pecl install APCu-beta
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/ext-apcu.ini

RUN apt-get update && apt-get install -y git subversion translate-toolkit && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN pear install SQL_Parser-0.6.0

#RUN apt-get update && apt-get install -y mc && rm -rf /var/lib/apt/lists/*

#ENTRYPOINT
#
RUN echo "Include /data/apache2/conf.d/*" >> /etc/apache2/apache2.conf

# support project code download with rsync whern $DOWNLOAD_RSYNC defined
RUN apt-get update && apt-get install -y rsync && rm -rf /var/lib/apt/lists/*
ENV DOWNLOAD_RSYNC ""
ADD run.sh /xt/run.sh
ENTRYPOINT ["/xt/run.sh"]
ADD startup/* /prj/startup/
