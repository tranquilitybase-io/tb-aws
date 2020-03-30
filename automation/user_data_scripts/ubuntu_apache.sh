#!/bin/bash

#echo "deb http://nginx.org/packages/mainline/ubuntu/ ${codename} nginx" >> /etc/apt/sources.list
#wget http://nginx.org/keys/nginx_signing.key
#apt-key add nginx_signing.key
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2