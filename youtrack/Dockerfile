FROM bigm/base-deb

#= oracle_jdk8
# install Oracle Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java8-installer \
    && rm -rf /var/cache/oracle-jdk8-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#= .oracle_jdk8

#= youtrack
ENV YOUTRACK_VERSION 6.0.12634
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /prj/bin/youtrack-$YOUTRACK_VERSION.jar http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar \
    && ln -s /prj/bin/youtrack-$YOUTRACK_VERSION.jar /prj/bin/youtrack.jar
#= .youtrack

# project files
ADD ./prj /prj

# configure
ENV YOUTRACK_MAX_METASPACE 250m
ENV YOUTRACK_TRUST_STORE_PASSWORD changeit
#ENV YOUTRACK_DATABASE_LOCATION /prj/data 	-Ddatabase.location=$YOUTRACK_DATABASE_LOCATION
CMD ["/prj/bin/run_youtrack"]
EXPOSE 8080