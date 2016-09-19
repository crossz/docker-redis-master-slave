FROM redis:3

MAINTAINER Cross Zheng (zhengxin@twitter.com)

ARG REQUIREPASS
ARG QUORUM=2
ARG CLIENTPORT=26379

ENV REQUIREPASS $REQUIREPASS
ENV SENTINEL_QUORUM $QUORUM
ENV CLIENTPORT $CLIENTPORT

ENV MASTERHOST localhost
ENV MASTERPORT 6479

ENV SENTINEL_DOWN_AFTER 30000
ENV SENTINEL_FAILOVER 180000


ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf

EXPOSE $CLIENTPORT

COPY sentinel-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sentinel-entrypoint.sh"]
