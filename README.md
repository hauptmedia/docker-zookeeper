# docker-zookeeper

Example run:

```bash
docker run -d \
-e SERVER_ID=1 \
-e TICK_TIME=2000 \
-e DATA_DIR=/var/lib/zookeeper/data \
-e DATA_LOG_DIR=/var/lib/zookeeper/log \
-e CLIENT_PORT=2181 \
-e INIT_LIMIT=2000 \
-e SYNC_LIMIT=2 \
-e SERVER= zoo1:2888:3888,zoo2:2888:3888,zoo3:2888:3888 \
-v /mnt/hdd/1/zookeeper/data:/var/lib/zookeeper/data \
-v /mnt/hdd/2/zookeeper/log:/var/lib/zookeeper/log \
hauptmedia/zookeeper
```

For more information about the configuration parameters have a look at http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html
