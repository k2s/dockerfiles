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

#= rundeck
ENV RUNDECK_VERSION 2.4.2
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /prj/bin/rundeck-launcher-$RUNDECK_VERSION.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RUNDECK_VERSION.jar \
    && ln -s /prj/bin/rundeck-launcher-$RUNDECK_VERSION.jar /prj/bin/rundeck-launcher.jar
# see http://rundeck.org/docs/administration/installation.html#installing-with-launcher
RUN /xt/tools/_apt_install mc nano
RUN java -XX:MaxPermSize=256m -jar /prj/bin/rundeck-launcher.jar --installonly
ENV PATH $PATH:/prj/bin/tools/bin
ENV RUNDECK_HOSTNAME rundeck
ENV RUNDECK_USER_PASSWORD rundeckpwd
ENV RUNDECK_FORWARDED false
ADD run_rundeck /prj/bin/run_rundeck
#= .rundeck

# configure
CMD ["/prj/bin/run_rundeck"]
EXPOSE 4440