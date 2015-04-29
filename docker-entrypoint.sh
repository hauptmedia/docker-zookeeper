#!/bin/bash
set -e

ZOO_CFG=/opt/zookeeper/conf/zoo.cfg

if [ -z "$SERVER_ID" ]; then
	echo >&2 'error:  missing SERVER_ID'
	echo >&2 '  Did you forget to add -e SERVER_ID=... ?'
	exit 1
fi

TICK_TIME=${TICK_TIME:-2000}
DATA_DIR=${DATA_DIR:-/var/lib/zookeeper/data}
CLIENT_PORT=${CLIENT_PORT:-2181}
INIT_LIMIT=${INIT_LIMIT:-2000}
SYNC_LIMIT=${SYNC_LIMIT:-2}

echo "tickTime=${TICK_TIME}" >${ZOO_CFG}

echo "dataDir=${DATA_DIR}" >>${ZOO_CFG}

if [ ! -d "$DATA_DIR" ]; then
	mkdir -p $DATA_DIR
fi

if [ -n "$DATA_LOG_DIR" ]; then
	echo "dataLogDir=${DATA_LOG_DIR}" >>${ZOO_CFG}

	if [ ! -d "$DATA_LOG_DIR" ]; then
		mkdir -p $DATA_LOG_DIR
	fi
fi

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


echo $SERVER_ID >${DATA_DIR}/myid

exec "$@"
