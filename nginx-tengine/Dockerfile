FROM bigm/nginx

RUN apt-get -yq --force-yes remove nginx-common \
  rm -fr /etc/nginx
COPY tengine_2.1.0-1_amd64.deb /tengine.deb
RUN dpkg --install /tengine.deb \
  && rm -f /tengine.deb
