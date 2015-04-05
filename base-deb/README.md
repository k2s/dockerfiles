## Build with apt cache enabled

The file _shared/detect-http-proxy_ configures apt to detect local proxy running on IP 172.17.42.1:3142.
  
To start apt cache server on your build machine you should start:
    
    docker pull sameersbn/apt-cacher-ng:latest
    docker rm -f apt-cache
    docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
    
    docker run --name=squid --rm -ti -p 3129:3129 jpetazzo/squid-in-a-can bash
          
To run apt-cache-ng on system boot create _/etc/systemd/system/apt-cache-ng.service_:
   
    [Unit]
    Description=apt-cache-ng container
    After=docker.service
    
    [Service]
    Restart=always
    ExecStartPre=/usr/bin/docker pull sameersbn/apt-cacher-ng:latest
    ExecStartPre=-/usr/bin/docker rm -f apt-cache
    ExecStart=/usr/bin/docker run --name=apt-cache -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
    ExecStop=-/usr/bin/docker rm -f apt-cache
    
    [Install]
    WantedBy=local.target       
    
And enable it on boot:
    
    systemctl daemon-reload
    systemctl enable apt-cache-ng.service
    
    