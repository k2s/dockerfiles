#Postman+DKIM enabled mailhub

##Starting

    docker run -ti --rm --name mailhub \
        -v /myconfig/mailhub/etc/opendkim/keys:/etc/opendkim/keys \
        quay.io/bigm/mailhub

##Test

Get into mailhub shell:

    docker exec -ti mailhub bash
    
Send test email:

    cat <<EOF |
    Subject: postfix test mail
    
    line 1
    line 2
    EOF
    sendmail user@example.com

##Dynamic reconfiguration

    docker exec mailhub /xt/postfix-reconfig.sh

##DKIM

https://www.howtoforge.com/set-up-dkim-domainkeys-identified-mail-working-with-postfix-on-centos-using-opendkim

    # list of active domains
    docker exec -ti <container> sh -c "cat /etc/opendkim/keys/*/mail.txt"
    
    # to validate obtain email from http://dkimvalidator.com and replace upper case text:  
    echo "dkim test mail body" | mail -r from_dkim@EXAMPLE.COM -s "dkim test mail " EXAMPLE@dkimvalidator.com
  
##TODO  
