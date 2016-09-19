#!/bin/sh

sed -i "s/\$SENTINEL_QUORUM/$SENTINEL_QUORUM/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWN_AFTER/$SENTINEL_DOWN_AFTER/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /etc/redis/sentinel.conf
sed -i "s/port 26379/port $CLIENTPORT/g" /etc/redis/sentinel.conf
sed -i "s/\$REQUIREPASS/$REQUIREPASS/g" /etc/redis/sentinel.conf
sed -i "s/\$MASTERHOST/$MASTERHOST/g" /etc/redis/sentinel.conf
sed -i "s/\$MASTERPORT/$MASTERPORT/g" /etc/redis/sentinel.conf


exec docker-entrypoint.sh redis-server /etc/redis/sentinel.conf --sentinel
