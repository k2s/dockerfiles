FROM bigm/nodejs

# https://github.com/haraka/Haraka/blob/master/Dockerfile
# https://github.com/gbleux/docker-haraka/blob/master/Dockerfile

RUN npm -g install Haraka

#groupmod -g NEWGID OLDGID
VOLUME /data
EXPOSE 25 587

#ADD root/ /
## folders under /xt/defaults will be populated in instance if they are empty
#RUN mkdir -p /xt/defaults/etc \
#    && cp -rp /etc/confd /xt/defaults/etc/confd
#
## final
#ADD supervisor.d/* /etc/supervisord.d/
#ADD startup/* /prj/startup/