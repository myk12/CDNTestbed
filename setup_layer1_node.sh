#!/bin/bash

# set up basic env
cd utils
./basic_env.sh
cd ..

# install varnish
cd varnish
./install-varnish.sh
cd ..
