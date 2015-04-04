FROM bigm/base-deb

#= oracle_jdk7
# install Oracle Java
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java7-installer \
    && rm -rf /var/cache/oracle-jdk7-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
#= .oracle_jdk7

#= gocd
ENV GOCD_VERSION 14.4.0-1356
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-$GOCD_VERSION.deb f4ebef6d75735b884fc6eeaa8e53a3314f032bdc\
    && dpkg -i /tmp/go-server.deb \
    && rm /tmp/go-server.deb
    && sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server
#= .gocd

# configure
#CMD ["/prj/bin/run_gocd"]
EXPOSE 8153 8154
