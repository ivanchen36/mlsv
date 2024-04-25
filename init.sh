#! /bin/sh

sudo yum install -y libidn.i686 libstdc++.i686
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl098e-0.9.8e-29.el7.centos.3.i686.rpm
sudo yum localinstall -y openssl098e-0.9.8e-29.el7.centos.3.i686.rpm
