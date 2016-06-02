FROM debian:jessie-backports

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        checkinstall \
        lsb-release \
        make \
        php5-dev \
        php-pear \
        wget

VOLUME ["/src", "/pkg"]
