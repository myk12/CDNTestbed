# install libraries
sudo apt install -y build-essential ca-certificates zlib1g-dev libpcre3 libpcre3-dev libssl-dev cmake ninja-build

# install nginx
wget https://nginx.org/download/nginx-1.25.1.tar.gz
tar -xvf nginx-1.25.1.tar.gz
cd nginx-1.25.1
./configure --with-debug \
    --with-pcre \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_v3_module \
    --without-http_rewrite_module
make -j32
sudo make install

# set environment
echo "PATH=\$PATH:/usr/local/nginx/sbin"


# clean
sudo rm -rf  nginx-1.25.1*
