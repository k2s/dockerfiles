FROM bigm/base-deb-minimal:latest

ENV DEBIAN_FRONTEND noninteractive

# copy tool scripts needed in this Dockerfile
COPY tools/_apt_install /xt/tools/_apt_install

# cached apt-get
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN /xt/tools/_apt_install netcat apt-utils
# http://askubuntu.com/questions/53443/how-do-i-ignore-a-proxy-if-not-available
# docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
ADD shared/detect-http-proxy /etc/apt/detect-http-proxy
ADD shared/30detectproxy etc/apt/apt.conf.d/30detectproxy

# set locale to UTF-8
#ENV LANG C.UTF-8
RUN /xt/tools/_apt_install locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && echo "LC_ALL=en_US.UTF-8" > /etc/default/locale \
    && echo "LANG=en_US.UTF-8" >> /etc/default/locale

# upgrade Ubuntu
RUN apt-get update \
    && apt-get -yqq --no-install-recommends upgrade \
    && rm -rf /var/lib/apt/lists/*

# install all /xt/tools
RUN /xt/tools/_apt_install curl
COPY tools /xt/tools