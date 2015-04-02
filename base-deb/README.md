## Build with apt cache enabled

The file _shared/detect-http-proxy_ configures apt to detect local proxy running on IP 172.17.42.1:3142.
  
To start apt cache server on your build machine you should start:
    
    docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
     