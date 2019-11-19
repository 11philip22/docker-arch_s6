FROM archlinux/base

COPY root/ /
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/

RUN /usr/local/bin/install.sh

ENTRYPOINT ["/init"]