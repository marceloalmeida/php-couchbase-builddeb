FROM marceloalmeida/php-docker:7.1

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

WORKDIR "/root"

ENV DEBIAN_FRONTEND noninteractive

# INSTALL BUILDER DEPENDENCIES
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  build-essential \
  ca-certificates \
  checkinstall \
  lsb-release \
  make \
  php7.1-dev \
  php-igbinary \
  re2c \
  runawk \
  wget

COPY src /src

# INSTALL PACKAGES DEPENDENCIES
RUN mkdir /pkg
RUN wget -q http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-3-amd64.deb && \
  dpkg -i /root/*.deb && \
  apt-get update && \
  apt-get install -y libcouchbase-dev libcouchbase2-bin

ENV VERSION 2.3.2

# CREATE PACKAGE
RUN wget -q https://pecl.php.net/get/couchbase-$VERSION.tgz && \
  tar -zxvf couchbase-$VERSION.tgz && \
  cd couchbase-$VERSION && \
  cp -r /src/* /root/couchbase-$VERSION/. && \
  phpize && \
  ./configure && \
  checkinstall -y --install=no --pkgname='php7.1-couchbase' --pkgversion='$VERSION' --pkggroup='php' --pkgsource='https://github.com/couchbase/php-couchbase' --maintainer='Marcelo Almeida \<marcelo.almeida@jumia.com\>' --requires='php7.1-common \(\>= 7.1.5\), php7.1-json \(\>= 7.1.5\), php-igbinary \(\>= 2.0.1\), libcouchbase2-core \(\>= 2.7.5\)' --include=include_etc

VOLUME ["/pkg"]
