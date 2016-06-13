FROM marceloalmeida/php-docker:latest

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

WORKDIR "/root"

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 2.2.0beta3

# INSTALL BUILDER DEPENDENCIES
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  build-essential \
  ca-certificates \
  checkinstall \
  lsb-release \
  make \
  php7.0-dev \
  re2c \
  runawk \
  wget

COPY src /src

# INSTALL PACKAGES DEPENDENCIES
RUN mkdir /pkg
RUN wget -q http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-2-amd64.deb ;\
  dpkg -i /root/*.deb ;\
  apt-get update ;\
  apt-get install -y libcouchbase-dev libcouchbase2-bin

# CREATE PACKAGE
RUN wget -q https://pecl.php.net/get/couchbase-$VERSION.tgz ;\ ;\
  tar -zxvf couchbase-$VERSION.tgz ;\
  cd couchbase-$VERSION ;\
  cp -r /src/* /root/couchbase-$VERSION/. ;\
  phpize ;\
  ./configure ;\
  checkinstall -y --install=no --pkgname='php7.0-couchbase' --pkgversion='$VERSION-aig' --pkggroup='php' --pkgsource='https://github.com/couchbase/php-ext-couchbase' --maintainer='Marcelo Almeida \<marcelo.almeida@jumia.com\>' --requires='php7.0-common \(\>= 7.0.7\), php7.0-json \(\>= 7.0.7\), libcouchbase2-core \(\>= 2.6.0\)' --include=include_etc

VOLUME ["/pkg"]
