#!/bin/sh
set -ex
wget http://www.vips.ecs.soton.ac.uk/supported/8.0/vips-8.0.1.tar.gz
tar -xzvf vips-8.0.1.tar.gz
cd vips-8.0.1 && ./configure --prefix=/usr && make && sudo make install
