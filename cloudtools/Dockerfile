FROM bigm/base-deb-tools

# git
RUN /xt/tools/_apt_install git-flow

# interact with S3 bucket
RUN /xt/tools/_apt_install s3cmd

# Amazon CLI
RUN /xt/tools/_apt_install python-pip jq
RUN pip install awscli

# zsh
WORKDIR /tmp
RUN /xt/tools/_apt_install zsh \
    && git clone --recursive https://github.com/sorin-ionescu/prezto.git zprezto \
    && wget https://raw.githubusercontent.com/Kentzo/git-archive-all/master/git_archive_all.py \
    && mv /tmp/git_archive_all.py /tmp/git-archive-all && chmod +x /tmp/git-archive-all \
    && cd /tmp/zprezto \
    && /tmp/git-archive-all /tmp/zprezto.tar.bz2 \
    && tar -xf /tmp/zprezto.tar.bz2 \
    && mv /tmp/zprezto /root/.zprezto \
    && rm -fr /tmp/zprezto /tmp/zprezto.tar.bz2 /tmp/git-archive-all \
    && zsh -c 'setopt EXTENDED_GLOB && for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

# docker
RUN /xt/tools/_apt_install docker.io

# install Go language
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
RUN go get github.com/tools/godep

# some dev tools for future scripts
RUN /xt/tools/_apt_install dialog autossh

# PHP to run xtcloud build tool
RUN /xt/tools/_apt_install php5-cli php-pear libyaml-dev php5-dev build-essential \
    && yes "" | pecl install yaml \
    && echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini \
    && php5enmod yaml \
    && /xt/tools/_apt_remove php5-dev php-pear build-essential

# rsync client needed for deployment
RUN /xt/tools/_apt_install rsync

# INI file manipulation from shell scripts
RUN pip install crudini

## kubernetes
#ENV VERSION_KUBERNETES 0.18.2
#RUN wget https://storage.googleapis.com/kubernetes-release/release/v${VERSION_KUBERNETES}/bin/linux/amd64/kubectl \
#    && chmod +x kubectl \
#    && mv kubectl /usr/local/bin/

# fleetctl - https://github.com/coreos/fleet/releases
ENV VERSION_FLEET 0.11.5
WORKDIR /tmp
RUN wget -nv https://github.com/coreos/fleet/releases/download/v${VERSION_FLEET}/fleet-v${VERSION_FLEET}-linux-amd64.tar.gz && \
  tar -xvf fleet-v${VERSION_FLEET}-linux-amd64.tar.gz && \
  mv /tmp/fleet-v${VERSION_FLEET}-linux-amd64/fleetctl /usr/local/bin/fleetctl && \
  rm -rf /tmp/fleet-v${VERSION_FLEET}-linux-amd64 /tmp/fleet-v${VERSION_FLEET}-linux-amd64.tar.gz
#ENV FLEETCTL_ENDPOINT http://10.1.42.1:4001

# etcdctl - https://github.com/coreos/etcd/releases
ENV VERSION_ETCD 2.2.2
WORKDIR /tmp
RUN wget -nv https://github.com/coreos/etcd/releases/download/v${VERSION_ETCD}/etcd-v${VERSION_ETCD}-linux-amd64.tar.gz && \
  tar -xvf etcd-v${VERSION_ETCD}-linux-amd64.tar.gz && \
  mv /tmp/etcd-v${VERSION_ETCD}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
  rm -rf /tmp/etcd-v${VERSION_ETCD}-linux-amd64 /tmp/etcd-v${VERSION_ETCD}-linux-amd64.tar.gz
#ENV ETCDCTL_PEERS 10.1.42.1:4001

# Ansible
RUN /xt/tools/_ppa_install ppa:ansible/ansible ansible
RUN ansible-galaxy install defunctzombie.coreos-bootstrap

# NFS client
RUN /xt/tools/_apt_install nfs-common portmap

# final settings
ENV PATH $PATH:/xt/hosting/bin
RUN echo "set-option -g default-shell /bin/zsh" > /root/.tmux.conf
RUN echo "export TERM=xterm-color" >> /root/.bashrc
WORKDIR /prj
CMD ["zsh"]
