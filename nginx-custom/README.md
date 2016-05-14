# nginx-tengine

Produces NGINX 1.8.0 with [nginx-upstream-dyanmic-servers](https://github.com/k2s/nginx-upstream-dyanmic-servers) module. 

## Build

We need to compile Nginx and then replace original Nginx with produced DEB file.
 
    # to create tengine_${VER}-1_amd64.deb in current folder
    ./compile-nginx.sh
    
    # to play with compilation use 
    ./compile-nginx.sh bash  
    # then customize and run examples/nginx-upstream-dyanmic-servers.sh in Docker instance 
    
    # produce final image
    docker build -t bigm/nginx-custom

## Start

See bigm/nginx image.
