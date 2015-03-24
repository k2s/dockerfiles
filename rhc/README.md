# bigm/rhc

## Build localy

    docker build -t bigm/rhc .

## Run

You should map mount following folders to the image:

* `~/.openshift` - you should create this directory on your host before, it will contain settings from `rhc setup`
* `~/.ssh` - ssh private key and ssh config file which will allow you to connect to OpenShift servers


    docker run --rm --name rhc -ti \
        -v ~/.openshift:/root/.openshift \
        -v ~/.ssh:/private \
        bigm/rhc bash
