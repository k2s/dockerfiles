FROM bigm/base-deb

#= java
# install Oracle Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java8-installer \
    && rm -rf /var/cache/oracle-jdk8-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#= .java

#= openfire
ENV OPENFIRE_VERSION 3.9.3
RUN /xt/tools/_apt_install adduser
RUN /xt/tools/_download /tmp/openfire_${OPENFIRE_VERSION}_all.deb http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb \
    && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
    && rm -rf /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
#= .openfire

# project files
ADD run_openfire /prj/bin/run_openfire

# configure
#CMD ["/prj/bin/run_openfire"]
EXPOSE 3478 3479 5222 5223 5229 7070 7443 7777 9090 9091

VOLUME ["/prj/data/openfire"]