#!/bin/sh
set -ex
wget http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.30/gobject-introspection-1.30.0.tar.xz
tar -xvf gobject-introspection-1.30.0.tar.xz
cd gobject-introspection-1.30.0 && ./configure --prefix=/usr && make && sudo make install
cd ../
wget http://www.vips.ecs.soton.ac.uk/supported/8.0/vips-8.0.1.tar.gz
tar -xzvf vips-8.0.1.tar.gz
cd vips-8.0.1 && ./configure --prefix=/usr && make && sudo make install