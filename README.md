# Redis-Sentinel Cluster Distributed



The difference from https://github.com/crossz/docker-redis-sentinel-compose is that 

1. Distributed, i.e. this is used to replace those redis nodes installed on separted nodes, while not on one local node for testing purpose or docker swarm. 
2. All parameters are assigned in the docker-compose.yml.


## Docker Compose template of Redis cluster

The tempalte defines the topology of the Redis cluster

```
version: '2'

services:
  master:
    build: 
      context: .
      args: 
        - PW=12345678
        - CLIENTPORT=6479
        - MASTERPORT=
        - MASTERHOST=localhost
    network_mode: "host"

  slave:
    build: 
      context: .
      args: 
        - PW=12345678
        - CLIENTPORT=6579
        - MASTERPORT=6479
        - MASTERHOST=localhost
    network_mode: "host"


  sentinel:
    build: 
      context: sentinel
      args: 
        - PW=12345678
        - QUORUM=1
    environment:
      - CLIENTPORT=26479
      - MASTERPORT=6479
      - MASTERHOST=localhost
      - SENTINEL_DOWN_AFTER=5000
      - SENTINEL_FAILOVER=5000
    network_mode: "host"


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





