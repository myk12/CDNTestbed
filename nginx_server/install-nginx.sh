# install libraries
sudo apt install -y ca-certificates zlib1g-dev libpcre3 libpcre3-dev libssl-dev cmake ninja-build liblua5.3-dev

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
