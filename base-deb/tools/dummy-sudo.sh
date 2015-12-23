#!/bin/bash
# In case you are creating image where you decide not to install *sudo* package, but some scripts depends on it you may do:
# ln -s /xt/tools/dummy-sudo.sh /bin/sudo

cmd=$1
shift

$cmd $@
