#BUILD_PUSH=hub,quay
FROM bigm/base-deb

# don't be ascetic
RUN /xt/tools/_install_admin_tools full

# use zsh & prezto
RUN /xt/tools/_apt_install zsh-static git \
    && git clone --recursive https://github.com/sorin-ionescu/prezto.git /root/.zprezto \
    && chsh -s /bin/zsh
ADD root/ /
