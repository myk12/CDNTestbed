# install libraries
apt install build-essential ca-certificates zlib1g-dev libpcre3 libpcre3-dev tar unzip libssl-dev wget curl git cmake ninja-build golang

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


