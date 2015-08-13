# base-deb

Features:

* based on minimal Ubuntu 14.04 image
* on instance start:
    * `run−parts /xt/startup` image declared startup scripts   
    * `run−parts $XT_USER_STARTUP` user configured startup scripts
* unified running process(es) with supervisord (http://supervisord.org/) 
* build with apt and download cache (see section below)
* handy scripts in `/xt/tools`
    * _apt_install:
    * _ppa_install:
    * _apt_remove:
    * _download:
    * _install_admin_tools:
    * _enable_ssmtp:
    * _enable_cron:
* fix TERM variable problems
* use `bigm/base-deb-tools` when creating new images

## Environment variables

* XT_USER_STARTUP
* XT_APT_PROXY
* XT_CACHE_REBUILD

## Build with apt cache enabled

The file _shared/detect-http-proxy_ configures apt to detect apt-cacher-ng proxy running on 172.17.42.1:3142.

Also script _tools/_download_ tries to utilize Squid3 proxy on 172.17.42.1:3128.
  
To start booth proxy services on your build machine you should start:
    
    docker pull bigm/proxy-cache:latest
    docker rm -f proxy-cache
    docker run --name=proxy-cache -d -v /var/cache/apt:/var/cache/apt-cacher-ng /var/cache/squid3:/var/spool/squid3 -p 3142:3142 -p 3128:3128 bigm/proxy-cache    
          
To run _proxy-cache_ image on system boot create _/etc/systemd/system/proxy-cache.service_:
   
    [Unit]
    Description=proxy-cache container
    After=docker.service
    
    [Service]
    Restart=always
    ExecStartPre=/usr/bin/docker pull bigm/proxy-cache:latest
    ExecStartPre=-/usr/bin/docker rm -f proxy-cache
    ExecStart=/usr/bin/docker run --name=proxy-cache -v /var/cache/apt:/var/cache/apt-cacher-ng -v /var/cache/squid3:/var/spool/squid3 -p 3142:3142 -p 3128:3128 bigm/proxy-cache
    ExecStop=-/usr/bin/docker rm -f proxy-cache
    TimeoutStartSec=0
    
    [Install]
    WantedBy=local.target       
    
And enable it on boot:
    
    systemctl daemon-reload
    systemctl enable proxy-cache.service
    
    