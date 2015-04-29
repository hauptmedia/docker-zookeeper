# docker-zookeeper

Example run:

```bash
docker run -d \
-e TICK_TIME=2000 \
-e DATA_DIR=/var/lib/zookeeper/ \
-e CLIENT_PORT=2181 \
-e INIT_LIMIT=2000 \
-e SYNC_LIMIT=2 \
-e SERVER= zoo1:2888:3888,zoo2:2888:3888,zoo3:2888:3888 \
-v /volumes/zookeeper:/var/lib/zookeeper \
hauptmedia/zookeeper
```
