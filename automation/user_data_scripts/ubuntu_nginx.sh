#!/bin/bash

codename=$(lsb_release -c | awk '{print $2}')
echo "deb http://nginx.org/packages/mainline/ubuntu/ ${codename} nginx" >> /etc/apt/sources.list

wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key

apt-get update -y
apt install nginx -y
systemctl start nginx