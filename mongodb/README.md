#MongoDB

##Start

To start server:

    docker run --rm -ti \
      -p 27017:27017 \
      -p 28017:28017 # optional web interface \
      -e MONGODB_OPTS='--storageEngine wiredTiger --nojournal' \ 
      --name mongo \
      bigm/mongodb
      
Command line utility:
    
    # interactive
    docker exec -ti mongo mongo
    
    # show log 
    docker exec mongo mongo log


##Environment variables

* MONGODB_OPTS: command line added to `mongod` start command (see `supervisor/mongodb.conf`) 

To provide more complicated configuration I recommend to mount `/etc/mongodb.conf` and pass
  
    ...
    -v /mymongod.conf:/etc/mongod.conf
    -e MONGODB_OPTS='--config /etc/mongod.conf'
    ...


##TODO 

* cluster https://registry.hub.docker.com/u/jacksoncage/mongo/
* speed https://github.com/torusware/speedus-mongo/blob/master/3.0/Dockerfile
* setting initial password https://github.com/tutumcloud/mongodb/blob/master/3.0/set_mongodb_password.sh 