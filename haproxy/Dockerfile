FROM bigm/base-deb

# install haproxy
RUN /xt/tools/_ppa_install ppa:vbernat/haproxy-1.5 ca-certificates libssl1.0.0 haproxy

# install confd
ENV ETCD_NODE 172.17.42.1:4001
ENV CONFD_VER 0.8.0
RUN /xt/tools/_download /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
	&& chmod +x /usr/local/bin/confd

ADD entrypoint.sh /entrypoint.sh
ADD confd /etc/confd

# final
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8080