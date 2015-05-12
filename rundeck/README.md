#rundeck

##Resources

* http://rundeck.org/

## Starting

Rundeck is installed into `/prj/bin/rdeck` folder.  
Data and configuration are stored in `/prj/data` which should be mounted by host to provide persistence.  
User login is managed in `/prj/data/rundeck/config/realm.properties`, only admin user is allowed on init. 

### Docker environment variables

* RUNDECK_START_URL - web context
* RUNDECK_SERVER_URL - full server URL used to build links
* RUNDECK_HOSTNAME - hostname where rundeck is serving
* RUNDECK_INITIAL_PASSWORD - initial password for admin user
* RUNDECK_FORWARDED - set to true if rundeck is behind proxy

Following variables are useful to store DB data for example to MySQL:

* RUNDECK_DB_URL - valid jdbc connection string, eg. `jdbc:mysql://mysql-server-ip/rundeckdb?autoReconnect=true`
* RUNDECK_DB_USER - db user name to connect to server
* RUNDECK_DB_PASSWORD - db user password
