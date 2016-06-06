FROM debian:jessie-backports

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

WORKDIR "/root"

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 2.1.0

# INSTALL BUILDER DEPENDENCIES
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  checkinstall \
  lsb-release \
  make \
  php5-dev \
  php-pear \
  wget

COPY src /src

# INSTALL PACKAGES DEPENDENCIES
RUN mkdir /pkg
RUN wget -q http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-2-amd64.deb ;\
  dpkg -i /root/*.deb ;\
  apt-get update ;\
  apt-get install -y libcouchbase-dev libcouchbase2-bin

# CREATE PACKAGE
RUN pecl download couchbase ;\
  tar -zxvf couchbase-$VERSION.tgz ;\
  cd couchbase-$VERSION ;\
  cp -r /src/* /root/couchbase-$VERSION/. ;\
  phpize ;\
  ./configure ;\
  checkinstall -y --install=no --pkgname='php5-couchbase' --pkgversion='$VERSION-aig' --pkggroup='php' --pkgsource='https://github.com/couchbase/php-ext-couchbase' --maintainer='Marcelo Almeida \<marcelo.almeida@africainternetgroup.com\>' --requires='php5-common \(\>= 5.6.0\), libcouchbase2-core \(\>= 2.6.0\)' --include=include_etc

VOLUME ["/pkg"]
