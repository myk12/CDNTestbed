# install libraries
sudo apt install -y build-essential ca-certificates zlib1g-dev libpcre3 libpcre3-dev libssl-dev cmake ninja-build liblua5.3-dev

# deprecated
# install nginx
#wget https://nginx.org/download/nginx-1.25.1.tar.gz
#tar -xvf nginx-1.25.1.tar.gz
#cd nginx-1.25.1
#./configure --with-debug \
#    --with-pcre \
#    --with-http_ssl_module \
#    --with-http_v2_module \
#    --with-http_v3_module \
#    --without-http_rewrite_module \
#    --with-http_lua_module

#make -j32
#sudo make install
#cd ..

# set environment
#echo "export PATH=\$PATH:/usr/local/nginx/sbin" >> ~/.bashrc

# copy files 
#sudo cp ./key/server.* /usr/local/nginx/conf
#sudo cp ./nginx.conf /usr/local/nginx/conf

# clean
#sudo rm -rf  nginx-1.25.1*

# install openresty
# what is openresty? -> https://openresty.org/en/
# get source
wget https://openresty.org/download/openresty-1.25.3.1.tar.gz
tar -xvf openresty-1.25.3.1.tar.gz
cd openresty-1.25.3.1

# compile and install
./configure -j16
make -j16
sudo make install
cd ..

# set config file
sudo cp nginx.conf /usr/local/openresty/nginx/conf/
sudo cp add-custom-weight.lua /usr/local/openresty/nginx/conf/

mkdir ~/resource/
cp index.html ~/resource/
# clean

rm -rf openresty-1.25.3.1*