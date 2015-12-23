# base-deb

This is minimal Ubuntu image and it is sometimes hard to troubleshoot when running images based on it. 
Have a look at `bigm/base-deb-tools` for image with more utilities.   

## Features:

* based on minimal Ubuntu 14.04 image
* build as single layer file
* build process uses APT and download cache
* collection of handy scripts
* fix some common problems
  * `TERM` variable
  * missing sudo if running everything under root user
* easy customizable:
  * default configuration files applied to image on start if empty folders are mounted as volumes
  * startup scripts
  * multiple processes with [supervisord](http://supervisord.org/) running as PID 1
  * start shell command after all deamons are started

## Environment variables

* `XT_DISABLE_STARTUP` will not execute scripts in `/xt/startup` on instance start
* `XT_PRJ_STARTUP` defaults to `/prj/startup` folder which will be copied over to `/xt/startup` on instance start
* `XT_RUN` script to execute after all deamons are started
* `XT_APT_PROXY` defaults to `apt_proxy:3142 172.17.42.1:3142`, see *Build with apt cache enabled* section
* `XT_CACHE_REBUILD` - used only to rebuild the whole `bigm/deb-base` image

If `/xt/tools/enable_ssmtp` applied
* `XT_MAIL_DISABLE`
* `XT_MAIL_SERVER`
* `XT_MAIL_ROOT_TO`

## Folders

### Reserver folders used in image
* `/xt` reserved for files *burned* into image  
* `/xt/tools` handy scripts for building images
* `/xt/startup` scripts executed on instance start
* `/xt/defaults` subfolders will be populated in instance if they will exist there but empty
* `/prj` reserved for project source code executed inside the Docker image
* `/prj/startup' default folder folder will be copied over to `/xt/startup` on instance start

### Suggested folders in build folder
* `<image folder>/root`
* `<image folder>/defaults`
* `<image folder>/supervisor.d`
* `<image folder>/startup`

## How to create inherited Docker images

Create *build folder* and create `Dockerfile` in it.

Now specify that your image will be based on `bigm/base-deb`.

    FROM bigm/base-deb
    
 or consider to use `bigm/base-deb-tools`
 
     FROM bigm/base-deb-tools

Next you install software you need in your image. There are few handy script (see *Tools reference* section) optimized for Docker I advice to use. See also my other images for usage examples.

Now it's time to add you custom files into the image. I suggest to create structute under `<image folder>/root` and add it to image:

    ADD root/ /
    
It will copy all files from `<image folder>/root` to images `/` folder. Existing files in image will be replaced.

The [CMD](https://docs.docker.com/engine/reference/builder/#cmd) command used in this image is starting [supervisord](http://supervisord.org/) and it is important not to override it if inherited deamons should also work in new image.

To add new daemon create config file under `<image folder>/supervisor.d` and merge this folder into your image:

    ADD supervisor.d/* /etc/supervisord.d/

The image contains already `/etc/supervisord.d/onstart.conf` which makes sure that script defined in environemnt variable `XT_RUN` will be executed after all other deamons are started. That is the best way how to run command with all deamons started (the script has to make sure that the deamons are really ready to server its purpose).
    
Sometimes you need to execute some commands before deamons are started. Create `<image folder>/supervisor.d`

    ADD startup/* /prj/startup/
    
Sometimes you want to initialize mounted volumes with standard configuration or data files, but then keep changes done by user. 
To achieve this copy folders you intent to mount into folder `/xt/defaults`:

    RUN mkdir -p /xt/defaults \
        && cp -rp /etc/icinga2 /xt/defaults/etc/icinga2 \
        && cp -rp /etc/icingaweb2 /xt/defaults/etc/icingaweb2
    
When instance will be started with volumes mounted to `/etc/icinga2` and/or `/etc/icingaweb2` subfolders in `/xt/defaults` will be copied to them if empty. 
Otherwise mounted content will be used to run the image. Subfolders in `/xt/defaults` are mapped relative to `/` in instance.    
    
Finaly add [ENV](https://docs.docker.com/engine/reference/builder/#env) and [EXPOSE](https://docs.docker.com/engine/reference/builder/#expose) and [VOLUME](https://docs.docker.com/engine/reference/builder/#volume) commands.

### Tools reference

#### _apt_install

Install one or multiple packages. 

This script optimizes invokation of `apt-get install` in following ways:

* it forces quite install of package without installing recommended packages
* removes leftovers not needed in Docker image
* for speed up see *Build with apt cache enabled* section


    RUN /xt/tools/_apt_install <space sepatated list of apt packages to install>

#### _ppa_install

Same as `_apt_install`, but first adds PPA repository, installs packages and then removes PPA repository.

    RUN /xt/tools/_ppa_install <ppa:user/name> <space sepatated list of apt packages to install>

#### _apt_remove

Remove installed packages. 

Sometimes you need to install packages needed in next build steps (e.g. *make*, *gcc*), but they are not needed in the final image. I recommend to install packages, build and remove packages with the same `RUN` commad.

    RUN /xt/tools/_apt_remove <space sepatated list of apt packages to uninstall>

#### _download

Download file and store it on disk. If valid md5 or sha1 hash is provided as third parameter the file will be also validated.

    /xt/tools/_download <target file in image> <url to download file from> [<md5 | sha1>]
    
For speed up see *Build with apt cache enabled* section

#### _install_admin_tools:

Running instance based on `bigm/base-deb` is misising many utilities you will need if troubleshooting. This script will install some basic utilities or install all tools which `bigm/base-deb-tools` image contains.

    # install some basic utilities (eg. mc nano vim less procps)
    /xt/tools/_install_admin_tools
    # install all tools available in bigm/base-deb-tools image
    /xt/tools/_install_admin_tools full

#### _enable_ssmtp:

TODO document it

#### _enable_cron:

TODO document it

## How to run inherited Docker images

    # start Docker container
    DID=$(docker run -d -e POSTFIX_relayhost=<my-smtp.example.com> \
      bigm/php-7-fpm-postfix)
      
    # excute your script
    docker exec -ti $DID php -f /xt/tools/mail_test.php <your email>

    # correctly shutdown the Docker instance to make sure that all daemons correctly save their data
    docker exec -ti $DID /xt/tools/shutdown.sh

Or use the `XT_RUN` environment variable to run command with all deamons started:

    docker run --name test -ti --rm -e \ 
        XT_MAIL_SERVER=xxxx.xtmotion.com \ 
        -e XT_RUN=/tmp/example.sh -v example.sh:/tmp/example.sh bigm/php-7-fpm-postfix     
       

## Build process

### Build with apt cache enabled

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
    
    
