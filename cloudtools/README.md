# bigm/cloudtools

## Preparation

This is general image which is depending on mounted volumes:

* `/xt/private` - secure data, like private keys and AWS credentials, etc.
* `/xt/hosting` - personal binaries, config files to manage cloud
* `/prj` - repository of files used to build particular cloud

Default location (see run example how to change it) for this folders on your host computer is `~/cloudtools/private`, `~/cloudtools/hosting` and `~/cloudtools/dockers`. 
You should create this folders before you start this Docker image. 

## Run

Example run command:

    # simple run
    ./run-cloudtools
    
    # customize file location on host
    PATH_BASE=~/xtcloud ./run-cloudtools

## Build locally

    docker build -t bigm/cloudtools .

If you change the first `RUN /xt/tools/_apt_proxy 0` to `RUN /xt/tools/_apt_proxy 1` it will force apt to use local apt caching proxy.
Unfortunately `docker build` command has parameter to pass variable to Dockerfile.

Then you have to start:
    
    docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
    
 