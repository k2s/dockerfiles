FROM bigm/base-deb

# basic utilities
RUN /xt/tools/_apt_install wget tar bzip2 unzip mc less tmux nano vim telnet curl inetutils-ping

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
RUN /xt/tools/_apt_install php5-cli php-pear pear-channels php5-dev build-essential php5-curl
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# ruby stuff
RUN /xt/tools/_apt_install ruby-full rubygems-integration
RUN gem install sass compass zen-grids sassy-buttons sass-globbing

# for better ssh tunnel creation
RUN /xt/tools/_apt_install autossh

#= oracle_jdk7
# install Oracle Java
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java7-installer \
    && rm -rf /var/cache/oracle-jdk7-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
#= .oracle_jdk7

#= liquibase
RUN /xt/tools/_apt_install mysql-client libmysql-java
RUN /xt/tools/_download /tmp/liquibase.zip http://sourceforge.net/projects/liquibase/files/Liquibase%20Core/liquibase-3.3.2-bin.zip/download \
    && unzip -q -d /opt/liquibase /tmp/liquibase.zip \
    && rm /tmp/liquibase.zip \
    && ln -s /usr/share/java/mysql-connector-java.jar /opt/liquibase/lib/mysql-connector-java.jar
#= .liquibase

# fix problems with composer cache
ENV COMPOSER_CACHE_DIR /dev/null

# final settings
ENV PATH $PATH:/xt/dev/bin
RUN echo "set-option -g default-shell /bin/zsh" > /root/.tmux.conf
RUN echo "export TERM=xterm-color" >> /root/.bashrc
WORKDIR /prj
CMD ["zsh"]

# some more php modules
RUN /xt/tools/_apt_install php5-apcu php5-mcrypt php5-gd php5-mysql \
    && php5enmod mcrypt
RUN /xt/tools/_apt_install translate-toolkit
RUN pear install SQL_Parser-0.6.0

RUN /xt/tools/_apt_install libyaml-dev \
    && yes "" | pecl install yaml \
    && echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini \
    && php5enmod yaml
