#Postman+DKIM enabled mailhub

##Starting



##Test


    cat <<EOF |
    Subject: postfix test mail
    
    line 1
    line 2
    EOF
    sendmail user@example.com

##Dynamic reconfiguration

##DKIM


    docker exec -ti <container> sh -c "cat /etc/opendkim/keys/*/mail.txt"
  
##TODO  
* optionaly we don't want to log rsyslogd to stdout