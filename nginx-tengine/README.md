# nginx-tengine

## Build

We need to compile Tengine https://github.com/alibaba/tengine and then replace Nginx with produced DEB file.
 
    # to create tengine_${VER}-1_amd64.deb in current folder
    ./compile-tengine.sh
    
    # to play with compilation use 
    ./compile-tengine.sh bash  
    # then customize and run examples/tengine.sh in Docker instance 
    
    # produce final image
    docker build -t bigm/nginx-tengine

## Start

See bigm/nginx image.
