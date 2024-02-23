# install libraries
apt install build-essential ca-certificates zlib1g-dev libpcre3 libpcre3-dev tar unzip libssl-dev wget curl git cmake ninja-build golang

# install openssl
wget --no-check-certificate https://www.openssl.org/source/openssl-3.0.0-alpha2.tar.gz
tar -xvf openssl-3.0.0-alpha2.tar.gz
cd openssl-3.0.0-alpha2
./config
make
sudo make install

# install boringSSL
git clone --depth=1 https://github.com/google/boringssl.git
cd boringssl
mkdir build
cd build
cmake -GNinja ..
ninja
cd ../..
mkdir -p boringssl/.openssl/lib
cp boringssl/build/crypto/libcrypto.a boringssl/build/ssl/libssl.a boringssl/.openssl/lib
cd boringssl/.openssl
ln -s ../include .
cd ../..

# install nginx
wget https://nginx.org/download/nginx-1.25.1.tar.gz
tar -xvf nginx-1.25.1.tar.gz
cd nginx-1.25.1
./configure --with-debug \
    --with-pcre \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_v3_module \
    --with-cc-opt="-I../boringssl/include" \
    --with-ld-opt="-L../boringssl/build/ssl -L../boringssl/build/crypto" \
    --without-http_rewrite_module
make
sudo make install


