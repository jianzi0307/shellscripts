#!/usr/bin/env bash
yum install -y wget gcc
wget http://download.redis.io/releases/redis-2.8.17.tar.gz
wget http://prdownloads.sourceforge.net/tcl/tcl8.5.18-src.tar.gz

tar -zxvf tcl8.5.18-src.tar.gz
cd tcl8.5.18
cd unix/
 ./configure;make;make test;make install

cd ../../
tar zxvf redis-2.8.17.tar.gz
cd redis-2.8.17
make MALLOC=libc




