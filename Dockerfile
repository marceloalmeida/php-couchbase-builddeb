FROM debian:jessie-backports

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

WORKDIR "/root"

ENV DEBIAN_FRONTEND noninteractive

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
RUN wget -q http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-3-amd64.deb ;\
  dpkg -i /root/*.deb ;\
  apt-get update ;\
  apt-get install -y libcouchbase-dev libcouchbase2-bin

ENV VERSION 2.3.2

# CREATE PACKAGE
RUN pecl download couchbase-$VERSION ;\
  tar -zxvf couchbase-$VERSION.tgz ;\
  cd couchbase-$VERSION ;\
  cp -r /src/* /root/couchbase-$VERSION/. ;\
  phpize ;\
  ./configure ;\
  checkinstall -y --install=no --pkgname='php5-couchbase' --pkgversion='$VERSION' --pkggroup='php' --pkgsource='https://github.com/couchbase/php-couchbase' --maintainer='Marcelo Almeida \<marcelo.almeida@jumia.com\>' --requires='php5-common \(\>= 5.6.0\), php5-json \(\>= 1.3.6\), libcouchbase2-core \(\>= 2.7.5\)' --include=include_etc

VOLUME ["/pkg"]
