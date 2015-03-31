
Minimal run command:

    docker run --rm -ti \
        -p 80:8080 \ 
        bigm/youtrack
        
Maximal run command:

    docker run --rm -ti \
        -e YOUTRACK_MAX_METASPACE=250m
        -e YOUTRACK_TRUST_STORE_PASSWORD=changeit
        -p 80:8080 \
        -v ???:???
        bigm/youtrack
