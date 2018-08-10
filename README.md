# Image for Redis Distributed Nodes only (no sentinel)

This is the git for a docker image on docker hub. https://hub.docker.com/r/crossz/redis-sentinel-distributed/

The sentinel image/repo is here: https://hub.docker.com/r/crossz/sentinel-redis-distributed/

----

The difference from https://github.com/crossz/docker-redis-sentinel-compose is that 

1. Distributed, i.e. this is used to replace those redis nodes installed on separted nodes, while not on one local node for testing purpose or docker swarm. 
2. All parameters are assigned in the docker-compose.yml.

----
## Docker Compose template of Redis cluster

The tempalte defines the topology of the Redis cluster

```
version: '3.1'

services:
  master:
    image: crossz/redis-sentinel-distributed
    #network_mode: "host"
    hostname: redis-master
    ports:
      - 6479:6479
    environment:
      - APPENDFSYNC=everysec
      - REQUIREPASS=12345678
      - CLIENTPORT=6479
      - CLIENTHOST=0.0.0.0
      - MASTERHOST=
      - MASTERPORT=
    volumes:
      - "/tmp/6479:/data"

  slave:
    image: crossz/redis-sentinel-distributed
    #network_mode: "host"
    hostname: redis-slave
    ports:
      - 6579:6579
    environment:
      - APPENDFSYNC=everysec
      - REQUIREPASS=12345678
      - CLIENTHOST=0.0.0.0
      - CLIENTPORT=6579
      - MASTERHOST=0.0.0.0
      - MASTERPORT=6479
    volumes:
      - "/tmp/6579:/data"
      
      
  sentinel:
    #network_mode: "host"
    hostname: redis-sentinel
    ports:
      - 26479:26479
    build: 
      context: sentinel
      args: 
        - PW=12345678
        - QUORUM=1
    environment:
      - CLIENTPORT=26479
      - MASTERPORT=6479
      - MASTERHOST=0.0.0.0
      - SENTINEL_DOWN_AFTER=5000
      - SENTINEL_FAILOVER=5000
    

```

There are following services in the cluster,

* master: Redis master
* slave:  Redis slave
* sentinel: Redis sentinel


The sentinels are configured with a "mymaster" instance with the following properties -

```
sentinel monitor mymaster redis-master 6379 1
sentinel down-after-milliseconds mymaster 5000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 5000
```

The details could be found in sentinel/sentinel.conf

The default values of the environment variables for Sentinel are as following

* SENTINEL_QUORUM: 1
* SENTINEL_DOWN_AFTER: 30000
* SENTINEL_FAILOVER: 180000





