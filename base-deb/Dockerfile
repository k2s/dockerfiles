FROM bigm/base-deb-minimal:latest

# let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# copy tool scripts needed in this Dockerfile
COPY tools/_apt_install /xt/tools/_apt_install

# cached apt-get
ENV XT_APT_PROXY 172.17.42.1:3142
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
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && echo "LC_ALL=en_US.UTF-8" > /etc/default/locale \
    && echo "LANG=en_US.UTF-8" >> /etc/default/locale

# upgrade Ubuntu
RUN apt-get update \
    && apt-get -yqq --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# make supervisor available
RUN /xt/tools/_apt_install python-setuptools \
    && /usr/bin/easy_install supervisor supervisor-stdout \
    && mkdir -p /etc/supervisor/conf.d \
    && mkdir -p /var/log/supervisor
ADD shared/supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/local/bin/supervisord", "-c",  "/etc/supervisor/supervisord.conf"]

# install all /xt/tools
RUN /xt/tools/_apt_install curl
COPY tools /xt/tools

# add our entrypoint
ENTRYPOINT ["/xt/tools/entrypoint.sh"]
