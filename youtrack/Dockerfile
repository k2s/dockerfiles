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

#= youtrack
ENV YOUTRACK_VERSION 6.0.12634
RUN mkdir -p /usr/local/youtrack \
    && mkdir -p /var/lib/youtrack \
    && /xt/tools/_download /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar \
    && ln -s /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar /usr/local/youtrack/youtrack.jar
#= .youtrack

# configure
ADD ./youtrack /xt/youtrack
EXPOSE 8080

ENV YOUTRACK_MAX_METASPACE 250m
ENV YOUTRACK_TRUST_STORE_PASSWORD changeit
CMD ["/xt/youtrack/run_youtrack"]