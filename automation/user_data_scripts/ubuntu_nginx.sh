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

EIP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i "s;EIP;${EIP};g" app1.conf

systemctl start nginx