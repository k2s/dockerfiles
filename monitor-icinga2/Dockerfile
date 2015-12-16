FROM bigm/base-deb-tools
# see: https://github.com/Icinga/docker-icinga2

# install icinga2
RUN /xt/tools/_ppa_install ppa:formorer/icinga \
    icinga2 icinga2-ido-mysql icingaweb2 php5-cli

# plugins
RUN /xt/tools/_apt_install nagios-plugins nagios-plugins-contrib nagios-plugins-extra
RUN /xt/tools/_apt_install apache2-utils

# syntax highlighting
RUN echo '## Icinga 2' >> /etc/nanorc \
    && echo 'include "/usr/share/icinga2-common/syntax/nano/icinga2.nanorc"' >> /etc/nanorc \
    && mkdir /usr/share/vim/vimfiles/{syntax,ftdetect} \
    && cp -a /usr/share/icinga2-common/syntax/vim/ftdetect/. /usr/share/vim/vimfiles/ftdetect/ \
    && cp -a /usr/share/icinga2-common/syntax/vim/syntax/. /usr/share/vim/vimfiles/syntax/

# create api certificates and users (will be overridden later)
RUN icinga2 api setup

# set icinga2 NodeName and create proper certificates required for the API
RUN sed -i -e 's/^.* NodeName = .*/const NodeName = "docker-icinga2"/gi' /etc/icinga2/constants.conf; \
 icinga2 pki new-cert --cn docker-icinga2 --key /etc/icinga2/pki/docker-icinga2.key --csr /etc/icinga2/pki/docker-icinga2.csr; \
 icinga2 pki sign-csr --csr /etc/icinga2/pki/docker-icinga2.csr --cert /etc/icinga2/pki/docker-icinga2.crt;

# configure PHP timezone
RUN sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/apache2/php.ini

# enable features
RUN icinga2 feature enable command

# create needed folders for later "icinga2 daemon" (based on /etc/init.d/icinga2 start)
ADD etc/ /etc/
RUN \
    mkdir -p /etc/icingaweb2/enabledModules \
    && chown -R www-data:icingaweb2 /etc/icingaweb2/* \
    && mkdir -p /var/run/icinga2/cmd \
    && chown nagios:nagios /var/run/icinga2 \
    && chmod 0755 /var/run/icinga2 \
    && chown nagios:nagios /var/run/icinga2/cmd \
    && chmod 2710 /var/run/icinga2/cmd

#    && find /etc/icingaweb2 -type f -name "*.ini" -exec chmod 660 {} \; \
#    && find /etc/icingaweb2 -type d -exec chmod 2770 {} \; \

ADD startup/* /prj/startup/
ADD supervisor/* /etc/supervisord.d/

EXPOSE 80 443 5665

ENV ICINGAWEB_USER admin
ENV ICINGAWEB_REALM "Icinga Web 2"
#ENV ICINGAWEB_PASSWORD

# TODO graphite support
