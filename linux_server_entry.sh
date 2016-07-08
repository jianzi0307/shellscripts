#!/usr/bin/env bash
 # 检查是否root用户
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script."
    exit 1
fi
yum -y update
yum install -y screen dstat wget lrzsz git vim tree
wget http://pkgs.repoforge.org/axel/axel-2.4-1.el6.rf.x86_64.rpm
rpm -ivh axel-2.4-1.el6.rf.x86_64.rpm
axel -n 10 http://soft.vpser.net/lnmp/lnmp1.2-full.tar.gz
tar zxvf lnmp1.2-full.tar.gz
cd lnmp1.2-full
sh install.sh