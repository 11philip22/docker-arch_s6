FROM archlinux/base

COPY root/ /

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /; \
    rm -rf /tmp/*

RUN bash /usr/local/sbin/fix_bins.sh

RUN mkdir -p /config \
             /defaults 

RUN useradd -u 1000 -U -d /config -s /sbin/nologin user

ENTRYPOINT ["/init"]