#!/bin/bash
TOP_DIR=`pwd`

sudo apt-get install -y autoconf libtool pkg-config

# compile openssl
git clone --depth 1 -b openssl-3.0.10+quic https://github.com/quictls/openssl
cd openssl
./config enable-tls1_3 --prefix=/usr/local/openssl/
make -j32
sudo make install
cd $TOP_DIR

# compile nghttp2
git clone https://github.com/tatsuhiro-t/nghttp2.git
cd nghttp2
autoreconf -fi
./configure --prefix=/usr/local/nghttp2 --enable-lib-only
make -j32
sudo make install
cd $TOP_DIR

# compile nghttp3
git clone -b v0.15.0 https://github.com/ngtcp2/nghttp3
cd nghttp3
autoreconf -fi
./configure --prefix=/usr/local/nghttp3 --enable-lib-only
make -j32
sudo make install
cd $TOP_DIR

# compile ngtcp2
git clone -b v0.19.1 https://github.com/ngtcp2/ngtcp2
cd ngtcp2
autoreconf -fi
./configure PKG_CONFIG_PATH=/usr/local/openssl/lib64/pkgconfig:/usr/local/nghttp3/lib64/pkgconfig LDFLAGS="-Wl,-rpath,/usr/local/openssl/lib64" --prefix=/usr/local/ngtcp2
make -j32
sudo make install
cd $TOP_DIR

# compile curl3
git clone https://github.com/curl/curl
cd curl
autoreconf -fi
LDFLAGS="-Wl,-rpath,/usr/local/openssl/lib64" ./configure --with-openssl=/usr/local/openssl --with-nghttp2=/usr/local/nghttp2 --with-nghttp3=/usr/local/nghttp3 --with-ngtcp2=/usr/local/ngtcp2
make -j32
sudo make install
sudo cp -r ./src/curl ./src/.libs /usr/local/bin
cd $TOP_DIR

# clean
sudo rm -rf openssl nghttp2 nghttp3 ngtcp2 