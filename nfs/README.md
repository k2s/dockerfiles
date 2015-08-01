#nfs

##Resources

* https://github.com/combro2k/docker-nfs-server/blob/master/Dockerfile
* https://github.com/jsafrane/kubernetes-nfs-example/tree/master/exporter

## Starting

    /usr/bin/docker run --name nfs \
        -v /mnt/a:/exports/a \
        -v /mnt/b:/exports/b_ro \        
        quay.io/bigm/nfs                                               

    IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' nfs)
    showmount -e $IP
    mkdir /tmp/nfs-share    
    mount -t nfs $IP:/exports/tmp /tmp/nfs-share

## Docker environment variables
 
NFS_EXPORT_FOLDER         subfolders in this directory will be exported, subforlders ending with _ro as read only

## TODO

* supervisord script nfs-server.conf needs improvement
* publish also NFSv4 shares ?