#!/bin/bash

. /etc/default/nfs-kernel-server
. /etc/default/nfs-common

rpcbind
rpc.statd -d
rpc.nfsd
rpc.mountd $RPCMOUNTDOPTS --foreground