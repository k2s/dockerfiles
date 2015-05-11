FROM bigm/base-jdk7

#= rundeck
ENV RUNDECK_VERSION 2.5.0
ENV RDECK_BASE /prj/bin/rdeck
ENV RUNDECK_HOSTNAME rundeck
ENV RUNDECK_USER_PASSWORD rundeckpwd
ENV RUNDECK_FORWARDED false

RUN mkdir -p $RDECK_BASE \
    && /xt/tools/_download $RDECK_BASE/rundeck-launcher-$RUNDECK_VERSION.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RUNDECK_VERSION.jar \
    && ln -s $RDECK_BASE/rundeck-launcher-$RUNDECK_VERSION.jar $RDECK_BASE/rundeck-launcher.jar
# see http://rundeck.org/docs/administration/installation.html#installing-with-launcher
RUN java -XX:MaxPermSize=256m -jar $RDECK_BASE/rundeck-launcher.jar --installonly
ENV PATH $PATH:$RDECK_BASE/tools/bin

ADD supervisor/rundeck.conf /etc/supervisor/conf.d/
ADD startup/rundeck /prj/startup/

ENV RUNDECK_START_URL /
EXPOSE 4440 4443
#= .rundeck
