FROM		hauptmedia/java:oracle-java7

ENV     	DEBIAN_FRONTEND noninteractive

ENV		ZK_VERSION	3.4.13
ENV		ZK_DOWNLOAD_URL http://mirror.netcologne.de/apache.org/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz 

ENV		ZK_INSTALL_DIR	/opt/zookeeper
ENV		ZK_DATA_DIR	/var/lib/zookeeper/data
ENV		ZK_DATA_LOG_DIR	/var/lib/zookeeper/log

# install needed debian packages & clean up
RUN		apt-get update && \
		apt-get install -y --no-install-recommends curl tar ca-certificates && \
		apt-get clean autoclean && \
        	apt-get autoremove --yes && \
        	rm -rf /var/lib/{apt,dpkg,cache,log}/

# download and extract kafka 
RUN		mkdir -p ${ZK_INSTALL_DIR} ${ZK_DATA_DIR} ${ZK_DATA_LOG_DIR} && \
		curl -L --silent ${ZK_DOWNLOAD_URL} | tar -xz --strip=1 -C ${ZK_INSTALL_DIR} && \
		cp ${ZK_INSTALL_DIR}/conf/zoo_sample.cfg ${ZK_INSTALL_DIR}/conf/zoo.cfg

# TCP port  2181 - Property from ZooKeeper's config zoo.cfg. The port at which the clients will connect.
# TCP ports 2888=peerport,3888=leaderport - Port used by ZooKeeper peers to talk to each other 

EXPOSE		2181 2888 3888	

COPY		docker-entrypoint.sh ${ZK_INSTALL_DIR}/bin/docker-entrypoint.sh

VOLUME          ["${ZK_DATA_DIR}", "${ZK_DATA_LOG_DIR}"]

WORKDIR		${ZK_INSTALL_DIR}

ENTRYPOINT	["bin/docker-entrypoint.sh"]

CMD		["bin/zkServer.sh", "start-foreground"]	
