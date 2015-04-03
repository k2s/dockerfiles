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

#= rundeck
ENV RUNDECK_VERSION 2.4.2
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /prj/bin/rundeck-launcher-$RUNDECK_VERSION.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RUNDECK_VERSION.jar \
    && ln -s /prj/bin/rundeck-launcher-$RUNDECK_VERSION.jar /prj/bin/rundeck.jar
ADD run_rundeck /prj/bin/run_rundeck
#= .rundeck

# configure
ENV RUNDECK_MAX_METASPACE 256m
CMD ["/prj/bin/run_rundeck"]
EXPOSE 8080