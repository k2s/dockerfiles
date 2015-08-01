#nfs

##Resources

* https://github.com/combro2k/docker-nfs-server/blob/master/Dockerfile
* https://github.com/jsafrane/kubernetes-nfs-example/tree/master/exporter

## Starting

    /usr/bin/docker run --name nfs \
        -v /mnt/a:/exports/a \
        -v /mnt/b:/exports/b_ro \        
        quay.io/bigm/nfs
                                                       
### Connect                                                       

    IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' nfs)
    showmount -e $IP
    mkdir /tmp/nfs-share    
    mount -t nfs $IP:/exports/tmp /tmp/nfs-share
    
### NFS connection over SSH tunnel

It works because:

* `/etc/default/nfs-kernel-server` is patched to use fix port 2233 in RPCMOUNTDOPTS
* generated `/etc/exports` contains keyword `insecure` to allow usage of complete port range  

First make sure that `ssh <user>@<docker_host>` works.
  
    # on docker host to know the Docker container IP
    IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' nfs)
     
    # on client
    ssh -Nv -L 3049:$IP:2049 -L 3233:$IP:2233 <user>@<docker_host>
    sudo mount -t nfs -o tcp,port=3049,mountport=3233 localhost:/exports/tmp /tmp/master

## Docker environment variables
 
NFS_EXPORT_FOLDER         subfolders in this directory will be exported, subforlders ending with _ro as read only, default is /exports

## TODO

* supervisord script nfs-server.conf needs improvement
* publish also NFSv4 shares ?