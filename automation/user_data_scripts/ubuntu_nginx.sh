#!/bin/bash

codename=$(lsb_release -c | awk '{print $2}')
echo "deb http://nginx.org/packages/mainline/ubuntu/ ${codename} nginx" >> /etc/apt/sources.list

wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key

apt update -y
apt install nginx -y

cd /etc/nginx/conf.d
cat <<EOF>> app1.conf
server {
  listen 80;
  listen [::]:80;

  server_name EIP;

  location / {
      proxy_pass http://internal_server_ip:80/;
  }
}
EOF

systemctl start nginx