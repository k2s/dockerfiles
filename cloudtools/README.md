# bigm/cloudtools

## Preparation

This is general image which is depending on mounted volumes:

* `/xt/private` - secure data, like private keys and AWS credentials, etc.
* `/xt/hosting` - personal binaries, config files to manage cloud
* `/xt/dockers` - repository of Dockerfiles

Default location (see run example how to change it) for this folders on your host computer is `~/cloudtools/private`, `~/cloudtools/hosting` and `~/cloudtools/dockers`. 
You should create this folders before you start this Docker image. 

## Run

Example run command:

    # simple run
    ./run-cloudtools
    
    # customize file location on host
    PATH_BASE=~/xtcloud ./run-cloudtools

## Build locally

The `_apt_proxy` script is forcing apt to use local apt caching proxy. So you have to start:
    
    docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
    
    docker build -t bigm/cloudtools .
