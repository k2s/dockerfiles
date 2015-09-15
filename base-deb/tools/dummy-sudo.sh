#!/bin/bash
# symlink to /bin/sudo if you have scripts which use sudo

cmd=$1
shift

$cmd $@
