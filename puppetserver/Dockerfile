FROM bigm/base-jdk7

# TODO expose volumes
# TODO on start update JAVA_ARGS in /etc/default/puppetserver

ENV REPO_NAME puppetlabs-release-pc1-trusty.deb
RUN /xt/tools/_download /tmp/$REPO_NAME https://apt.puppetlabs.com/$REPO_NAME \
    && dpkg -i /tmp/$REPO_NAME \
    && rm -f /tmp/$REPO_NAME
# http://tuxmea.blogspot.de/2015/05/puppet-enterprise-38-installation-steps.html
RUN /xt/tools/_apt_install puppetserver \
    zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
RUN /opt/puppetlabs/puppet/bin/gem install r10k \
    && ln -s /opt/puppetlabs/puppet/bin/r10k /opt/puppetlabs/bin/

#RUN apt-get update -y &&  apt-get install -y wget
#RUN wget -O /tmp/$REPO_NAME https://apt.puppetlabs.com/$REPO_NAME \
#    && dpkg -i /tmp/$REPO_NAME \
#    && rm -f /tmp/$REPO_NAME
#RUN apt-get update -y && apt-get install -y puppetserver

#ADD default-puppetserver /etc/default/puppetserver

RUN /xt/tools/_install_admin_tools

RUN mv /etc/puppetlabs /etc/puppetlabs_orig
ADD startup/* /prj/startup/

ENV PATH=/opt/puppetlabs/bin/:$PATH
EXPOSE 8140
#VOLUME /etc/puppetlabs

CMD [ "/opt/puppetlabs/bin/puppetserver", "foreground" ]
#docker run --rm -ti -v /home/k2s/Dev/dockerfiles/puppetserver/_current/etc:/etc/puppetlabs -p 8140:8140 bigm/puppetserver