FROM bigm/base-deb

# install confd
ENV CONFD_VER 0.9.0
RUN /xt/tools/_download /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
	&& chmod  +x /usr/local/bin/confd

# install haproxy
RUN /xt/tools/_ppa_install ppa:vbernat/haproxy-1.5 haproxy

# add haproxy templates
ADD confd /etc/confd

# final
ADD supervisor/* /etc/supervisor/conf.d/
ADD startup/* /prj/startup/
EXPOSE 8080 1000