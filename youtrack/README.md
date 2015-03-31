Youtrack
========

Minimal run command:

    docker run --rm -ti \
        -p 80:8080 \ 
        bigm/youtrack
        
Maximal run command:

    docker run --rm -ti \
        -e YOUTRACK_MAX_METASPACE=250m
        -e YOUTRACK_TRUST_STORE_PASSWORD=changeit
        -p 80:8080 \
        -v ~/youtrack/teamsysdata:/prj/data/teamsysdata \
        -v ~/youtrack/teamsysdata-backup:/prj/data/teamsysdata-backup \
        bigm/youtrack


Restore from a backup
    
    mkdir -p ~/youtrack/teamsysdata
    cd ~/youtrack/teamsysdata
    rm -rf *
    tar xvf ~/Youtrack_backup_file.tar.gz
    docker start youtrack
    
    