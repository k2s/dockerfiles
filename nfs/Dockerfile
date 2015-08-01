FROM bigm/base-deb

# install nfs
RUN /xt/tools/_apt_install nfs-kernel-server netbase

ENV NFS_EXPORT_FOLDER /exports
RUN mkdir -p $NFS_EXPORT_FOLDER

# final
ADD supervisor/* /etc/supervisor/conf.d/
ADD startup/* /prj/startup/
EXPOSE 111/udp 2049/tcp

ADD nfs-run.sh /usr/local/bin/nfs-run
#CMD ["/usr/local/bin/nfs-run"]