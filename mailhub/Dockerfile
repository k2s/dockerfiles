FROM bigm/base-deb-tools
# https://github.com/wader/postfix-relay
# https://registry.hub.docker.com/u/nightexcessive/docker-opendkim/dockerfile/
# https://github.com/nightexcessive/postfix-forwarder
# https://github.com/pocesar/docker-postfix-dovecot

RUN /xt/tools/_apt_install postfix perl opendkim opendkim-tools rsyslog pfqueue heirloom-mailx

RUN mkdir -p /etc/opendkim/keys

EXPOSE 25
VOLUME ["/var/lib/postfix", "/var/mail", "/var/spool/postfix", "/etc/opendkim/keys"]

ADD rsyslog.conf /etc/rsyslog.conf
COPY opendkim.conf /etc/opendkim.conf
COPY reconfig.sh /prj/reconfig.sh
ADD supervisor/* /etc/supervisord.d/
ADD startup/* /prj/startup/

# No TLS for connecting clients, trust docker network to be safe
ENV \
  POSTFIX_myhostname=hostname \
  POSTFIX_mydestination=localhost \
  POSTFIX_mynetworks=0.0.0.0/0 \
  POSTFIX_smtp_tls_security_level=may \
  POSTFIX_smtpd_tls_security_level=none
