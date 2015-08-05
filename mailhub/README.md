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

    docker exec mailhub /prj/reconfigure.sh

##DKIM


    docker exec -ti <container> sh -c "cat /etc/opendkim/keys/*/mail.txt"
  
##TODO  
* optionaly we don't want to log rsyslogd to stdout