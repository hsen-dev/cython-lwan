#!/bin/bash

# This simple script automates the installation of LWAN (https://lwan.ws/), as
# described here: https://github.com/lpereira/lwan/blob/master/README.md#build-commands .
# This will install LWAN in release mode.
#
# Warning: Make sure to have the required dependencies installed before running
# it (i.e. https://github.com/lpereira/lwan#minimum-to-build).

git clone git://github.com/lpereira/lwan
cd lwan

mkdir build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release

make
sudo make install
