FROM bigm/base-jdk7

#= gocd
ENV GOCD_VERSION 14.4.0-1356
RUN /xt/tools/_apt_install unzip adduser \
    && /xt/tools/_download /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-$GOCD_VERSION.deb f4ebef6d75735b884fc6eeaa8e53a3314f032bdc \
    && dpkg -i /tmp/go-server.deb \
    && rm /tmp/go-server.deb \
    && sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server \
    && /xt/tools/_apt_remove unzip
#= .gocd

RUN /xt/tools/_install_admin_tools

# configure
#CMD ["/prj/bin/run_gocd"]
EXPOSE 8153 8154
