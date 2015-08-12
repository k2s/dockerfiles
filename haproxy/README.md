#haproxy

##Resources

* http://seanmcgary.com/posts/automatically-scale-haproxy-with-confd-and-etcd
* https://github.com/michielbdejong/docker-haproxy-confd
* https://github.com/yaronr/dockerfile/tree/master/haproxy-confd

## Starting

    /usr/bin/docker run --name haproxy \
        -e ETCD_NODE=$ETCD_NODE \
        -e HAPROXY_STATS=1 \
        -e HAPROXY_STATS_PWD=mypassword \
        -p 80:80 \
        -p 39287:1000 \
        -v /path_to_merge_config/custom.cfg:/etc/haproxy/custom.cfg \
        quay.io/bigm/haproxy                

### Docker environment variables
 
HAPROXY_STATS       enable/disable haproxy stats (default 0)  
HAPROXY_STATS_PWD   protect haproxy stats with password (default none)  
HAPROXY_STATS_ADMIN enable management of backends (default 0)  

## Configuring haproxy

The haproxy config is generated based on [confd](https://github.com/kelseyhightower/confd) template located in `/etc/confd` folder.

### Etcd variables

http_auth -  
cookie_auth -  
block_robots -  

##Testing haproxy configuration templating with confd

###Start local etcd

Read https://github.com/coreos/etcd/blob/master/Documentation/docker_guide.md

    export HostIP="192.168.1.2"
    export ETCD_NODE="$HostIP:4001"
    
    docker run -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
     -d -ti --name etcd quay.io/coreos/etcd:v2.0.8 \
     -name etcd0 \
     -advertise-client-urls http://$HostIP:2379,http://$HostIP:4001 \
     -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
     -initial-advertise-peer-urls http://$HostIP:2380 \
     -listen-peer-urls http://0.0.0.0:2380 \
     -initial-cluster-token etcd-cluster-1 \
     -initial-cluster etcd0=http://$HostIP:2380 \
     -initial-cluster-state new

    etcdctl -C http://$HostIP:4001 member list

###Start interactive haproxy Docker instance with mapped configuration

    export HostIP="192.168.1.2"
    export ETCD_NODE="$HostIP:4001"

    mkdir /tmp/haproxy_etc
    chmod 0777 /tmp/haproxy_etc

    #cd <dockerfiles/haproxy folder>
     
    # to avoid errors with default errorfile directives
    docker run --rm -ti \
        -v /tmp/haproxy_etc:/etc/haproxy2 \
        --entrypoint /bin/cp \
        bigm/haproxy \
        -r /etc/haproxy/errors /etc/haproxy2/

    # start interactive session where you will compile templates
    docker run --rm -ti \
        -v $PWD/confd:/etc/confd \
        -v /tmp/haproxy_etc:/etc/haproxy \
        -v $PWD/supervisor/haproxy.conf:/etc/supervisord.d/haproxy.conf \
        -e ETCD_NODE=$ETCD_NODE \
        -e HAPROXY_STATS=1 \
        -e HAPROXY_STATS_PWD=mypwd \
        -P \
        --entrypoint bash \
        bigm/haproxy
           
    # generate temple and validate
    confd -node $ETCD_NODE -onetime && /usr/sbin/haproxy -c -f /etc/haproxy/haproxy.cfg         
    
###Use etcd api if needed

API https://coreos.com/etcd/docs/0.4.7/etcd-api/

    #ETCDCTL_PEERS=http://$ETCD_NODE
    
    # create backend config (it should use ttl)
    etcdctl --no-sync set '/lb/backends/youtrack.service/enabled' '1'
    etcdctl --no-sync set '/lb/backends/youtrack.service/http_auth' '1'
    etcdctl --no-sync set '/lb/backends/youtrack.service/cookie_auth' 'MyStagingProtectionCookieName'
            
    # create domain config
    etcdctl --no-sync set '/lb/domains/youtrack.example.com:80' '{"name":"youtrack.example.com","port":80,"backend":"youtrack.service","url":"\/"}'
            
    # remove domain config
    etcdctl rm /lb/domains --recursive
    curl -L -X DELETE http://$ETCD_NODE/v2/keys/lb/domains?recursive=true        
            
## SSL

TODO ssl support
