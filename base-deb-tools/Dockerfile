FROM bigm/base-deb

# don't be ascetic
RUN /xt/tools/_apt_install tar bzip2 zip p7zip unzip \
  mc less tmux nano vim heirloom-mailx \
  rsync wget curl dnsutils inetutils-ping telnet \
  procps psmisc
RUN echo "SELECTED_EDITOR=/usr/bin/vim.basic" > /root/.selected_editor