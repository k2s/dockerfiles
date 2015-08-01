#Puppet Server

## Starting

* create on your host empty folder eg. /opt/puppet-etc
* this folder will be populated with default configuration on first run


    docker run --rm -ti -v /opt/puppet-etc:/etc/puppetlabs -p 8140:8140 bigm/puppetserver
  
## TODO 

* on start update JAVA_ARGS in /etc/default/puppetserver