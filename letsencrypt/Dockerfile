#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=APP_VERSION
FROM bigm/base-deb-tools

# install pip
RUN /xt/tools/_apt_install python3-pip

ENV APP_VERSION=20160522
# install letsencrypt.sh with DNS hook
RUN cd /opt \
    && git clone https://github.com/lukas2511/letsencrypt.sh \
    && cd letsencrypt.sh \
    && mkdir hooks \
    && git clone -b k2s-patch-1 https://github.com/k2s/letsencrypt-dnsmadeeasy-hook hooks/dnsmadeeasy \
    && pip3 install -r hooks/dnsmadeeasy/requirements.txt

ENV DME_API_KEY ""
ENV DME_SECRET_KEY ""

WORKDIR /opt/letsencrypt.sh
RUN chmod -R 777 /opt/letsencrypt.sh