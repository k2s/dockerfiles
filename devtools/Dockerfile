# https://registry.hub.docker.com/_/centos/
#FROM centos:7
#FROM debian:wheezy
#FROM ubuntu:14.04
#FROM ubuntu-debootstrap:14.04
FROM textlab/ubuntu-essential

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

COPY tools /xt/tools

# cached apt-get
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN /xt/tools/_apt_install netcat
# http://askubuntu.com/questions/53443/how-do-i-ignore-a-proxy-if-not-available
# docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
ADD shared/detect-http-proxy /etc/apt/detect-http-proxy
ADD shared/30detectproxy etc/apt/apt.conf.d/30detectproxy

# basic utilities
RUN /xt/tools/_apt_install wget tar unzip mc less tmux nano vim telnet curl inetutils-ping

# VCS
RUN /xt/tools/_apt_install git-flow subversion

# interact with S3 bucket
RUN /xt/tools/_apt_install s3cmd

# Amazon CLI
RUN /xt/tools/_apt_install python-pip jq
RUN pip install awscli

# zsh
WORKDIR /tmp
RUN /xt/tools/_apt_install zsh \
    && git clone --recursive https://github.com/sorin-ionescu/prezto.git zprezto \
    && wget https://raw.githubusercontent.com/Kentzo/git-archive-all/master/git-archive-all \
    && chmod +x /tmp/git-archive-all \
    && cd /tmp/zprezto \
    && /tmp/git-archive-all /tmp/zprezto.tar.bz2 \
    && tar -xf /tmp/zprezto.tar.bz2 \
    && mv /tmp/zprezto /root/.zprezto \
    && rm -fr /tmp/zprezto /tmp/zprezto.tar.bz2 /tmp/git-archive-all \
    && zsh -c 'setopt EXTENDED_GLOB && for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

# nodej stuff
RUN /xt/tools/_apt_install nodejs nodejs-legacy npm
RUN npm install --global gulp bower yo

# php stuff
RUN /xt/tools/_apt_install php5-cli php-pear pear-channels php5-dev build-essential
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# ruby stuff
RUN /xt/tools/_apt_install ruby-full rubygems-integration
RUN gem install sass compass zen-grids sassy-buttons

# for better ssh tunnel creation
RUN /xt/tools/_apt_install autossh

# final settings
RUN /xt/tools/_apt_proxy 0
ENV PATH $PATH:/xt/dev/bin
RUN echo "set-option -g default-shell /bin/zsh" > /root/.tmux.conf
RUN echo "export TERM=xterm-color" >> /root/.bashrc
WORKDIR /prj
CMD ["zsh"]