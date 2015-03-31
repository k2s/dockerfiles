# https://registry.hub.docker.com/_/centos/
#FROM centos:7
#FROM debian:wheezy
#FROM ubuntu:14.04
#FROM ubuntu-debootstrap:14.04
FROM textlab/ubuntu-essential

ENV DEBIAN_FRONTEND noninteractive

# Set locale to UTF-8.
#ENV LANG C.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN echo LANG=\"en_US.UTF-8\" > /etc/default/locale

# copy out tool scripts
COPY tools /xt/tools

# cached apt-get
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN /xt/tools/_apt_install netcat apt-utils
# http://askubuntu.com/questions/53443/how-do-i-ignore-a-proxy-if-not-available
# docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
ADD shared/detect-http-proxy /etc/apt/detect-http-proxy
ADD shared/30detectproxy etc/apt/apt.conf.d/30detectproxy

# upgrade Ubuntu
RUN apt-get update \
    && apt-get -yqq --no-install-recommends upgrade \
    && rm -rf /var/lib/apt/lists/*

# some tools for /xt/tools
RUN /xt/tools/_apt_install curl