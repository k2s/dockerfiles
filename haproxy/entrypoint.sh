#!/bin/bash

if [ -z "$ETCD_NODE" ]
then
  echo "Missing ETCD_NODE env var"
  exit -1
fi

set -eo pipefail

#confd will start haproxy, since conf will be different than existing (which is null)

echo "[haproxy-confd] booting container. ETCD: $ETCD_NODE"

function config_fail()
{
	echo "Failed to start due to config error"
	exit -1
}

# Loop until confd has updated the haproxy config
n=0
# test: confd -onetime -node "$ETCD_NODE" -keep-stage-file
echo "[haproxy-confd] waiting for initial haproxy.cfg refresh"
until confd -onetime -node "$ETCD_NODE"; do
  if [ "$n" -eq "4" ];  then
      # config_fail;
      n=5
  else
    n=$((n+1))
  fi
  echo "[haproxy-confd] haproxy.cfg generatio process failed, waiting again"
  sleep $n
done

echo "[haproxy-confd] Initial HAProxy config created. Starting confd"

confd -node "$ETCD_NODE"

## Run confd in the background to watch the upstream servers
#confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/crt-list.toml >> /var/log/output.log 2>&1 &
#confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/haproxy.toml >> /var/log/output.log 2>&1 &
#
#tail -f /var/log/output.log