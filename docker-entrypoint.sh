#!/bin/bash
set -e

ZOO_CFG=/opt/zookeeper/conf/zoo.cfg

TICK_TIME=${TICK_TIME:-2000}
DATA_DIR=${DATA_DIR:-/var/lib/zookeeper/}
CLIENT_PORT=${CLIENT_PORT:-2181}
INIT_LIMIT=${INIT_LIMIT:-2000}
SYNC_LIMIT=${SYNC_LIMIT:-2}

echo "tickTime=${TICK_TIME}" >${ZOO_CFG}
echo "dataDir=${DATA_DIR}" >>${ZOO_CFG}
echo "clientPort=${CLIENT_PORT}" >>${ZOO_CFG}
echo "initLimit=${INIT_LIMIT}" >>${ZOO_CFG}
echo "syncLimit=${SYNC_LIMIT}" >>${ZOO_CFG}

if [ -n "$SERVER" ]; then
	i=1
	for server in $(echo $SERVER | tr ',' ' '); do
		echo server.${i}=$server >>${ZOO_CFG}
		let "i = i + 1"
	done
fi




exec "$@"
