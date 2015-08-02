#Nagios3 with Adagios UI

## Starting
 
 
    docker run --name nagios -v /tmp/nagios3:/etc/nagios3 --rm -ti -p 80:80 bigm/monitor-nagios 

## Links

* http://localhost/adagios
* http://localhost/nagios3
* http://localhost/pnp4nagios

## TODO

* ENV variables to init and push /etc/nagios3 to Git repository
* consider patching original files instead of copying sites/ folder over to image


    RUN cp -f /etc/nagios3/apache2.conf /etc/apache2/sites-enabled/nagios3.conf
    RUN cp -f /usr/local/lib/python2.7/dist-packages/adagios/apache/adagios.conf /etc/apache2/sites-enabled/adagios.conf
    RUN cp -f /etc/pnp4nagios/apache.conf /etc/apache2/sites-enabled/pnp4nagios.conf    
    
