#!/usr/bin/env bash

# POSTFIX_var env -> postconf -e var=$POSTFIX_var
for e in ${!POSTFIX_*} ; do postconf -e "${e:8}=${!e}" ; done
#chown -R postfix:postfix /var/lib/postfix /var/mail /var/spool/postfix

# DKIM config
FOLDER=/etc/opendkim/keys
if [ "$(ls -A $FOLDER)" ]; then
  postconf -e milter_protocol=2
  postconf -e milter_default_action=accept
  postconf -e smtpd_milters=inet:localhost:12301

  rm -f /etc/opendkim/KeyTable
  rm -f /etc/opendkim/SigningTable

  for DIR in "$FOLDER"/* ; do
    d=$(basename $DIR)
    if [ ! "$(ls -A $DIR)" ]; then
      echo "generating DKIM key for domain: $d"
      (cd "$DIR" && opendkim-genkey --selector=mail --domain=$d && chown opendkim:opendkim mail.private)
    fi

    echo "mail._domainkey.$d $d:mail:/etc/opendkim/keys/$d/mail.private" >> /etc/opendkim/KeyTable
    echo "*@$d mail._domainkey.$d" >> /etc/opendkim/SigningTable
  done
else
  postconf -X milter_protocol
  postconf -X milter_default_action
  postconf -X smtpd_milters
fi

chown -R opendkim:opendkim /etc/opendkim
chmod -R go-wrx /etc/opendkim/keys
if [ ${1:-1} -eq 1 ]; then
  # reload postfix and dkim
  /etc/init.d/opendkim restart
  /etc/init.d/postfix reload
fi
