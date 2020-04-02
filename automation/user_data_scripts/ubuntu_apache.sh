#!/bin/bash

#echo "deb http://nginx.org/packages/mainline/ubuntu/ ${codename} nginx" >> /etc/apt/sources.list
#wget http://nginx.org/keys/nginx_signing.key
#apt-key add nginx_signing.key
apt update -y
apt install apache2 -y

cd /var/www/html/
cat <<EOF>>index.html
<HTML>
        <HEAD>
                <TITLE>GFT's AWS Landing Zone</TITLE>
        </HEAD>
        <BODY BGCOLOR="FFFFFF">
                <CENTER><IMG SRC="clouds.jpg" ALIGN="BOTTOM"> </CENTER>
                <HR>
                <a href="http://github.com/tranquilitybase-io/tb-aws">Link Name</a>
                is a link to the github repository
                <H1>This is a server in the Landing Zone</H1>
                <H2>It is exposed by an ingress VPC</H2>
                <P> We are building more and more stuff! </P>
                <BR> <B><I>Send us any advise....</I></B>
                <HR>
        </BODY>
</HTML>
EOF

systemctl start apache2
systemctl enable apache2 