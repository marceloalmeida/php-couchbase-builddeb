FROM marceloalmeida/php-docker:7.0

MAINTAINER Marcelo Almeida <marcelo.almeida@jumia.com>

WORKDIR "/root"

ENV \
  DEBIAN_FRONTEND="noninteractive" \
  VERSION="2.4.2"

# INSTALL BUILDER DEPENDENCIES
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  build-essential \
  ca-certificates \
  checkinstall \
  lsb-release \
  make \
  php7.0-dev \
  php7.0-igbinary \
  re2c \
  runawk \
  wget

COPY src /src

# INSTALL PACKAGES DEPENDENCIES
RUN mkdir /pkg && \
  wget -q http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb && \
  dpkg -i /root/*.deb && \
  apt-get update && \
  apt-get install -y libcouchbase-dev libcouchbase2-bin build-essential php-dev zlib1g-dev

# CREATE PACKAGE
RUN wget -q https://pecl.php.net/get/couchbase-$VERSION.tgz && \
  tar -zxvf couchbase-$VERSION.tgz && \
  cd couchbase-$VERSION && \
  cp -r /src/* /root/couchbase-$VERSION/. && \
  phpize && \
  ./configure && \
  checkinstall -y --install=no --pkgname='php7.0-couchbase' --pkgversion='$VERSION' --pkggroup='php' --pkgsource='https://github.com/couchbase/php-couchbase' --maintainer='Marcelo Almeida \<marcelo.almeida@jumia.com\>' --requires='php7.0-common \(\>= 7.0.7\), php7.0-json \(\>= 7.0.7\), php-igbinary \(\>= 2.0.1\), libcouchbase2-core \(\>= 2.8.2\)' --include=include_etc

VOLUME ["/pkg"]
