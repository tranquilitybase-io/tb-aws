#!/bin/bash

#echo "*****Update the repositories*****"
sudo yum -y update

#echo "*****Installing EPEL*****"
sudo amazon-linux-extras install -y epel;

#echo "*****Installing dependencies packages*****"
sudo yum install -y nagios nrpe nagios-plugins-all httpd php;

#echo "*****Setting Email in contacts file*****"
sed -i "s/nagios@localhost/NETMON_EMAIL/" /etc/nagios/objects/contacts.cfg;

#echo "*****Checking Nagios Configuration*****"
/usr/sbin/nagios -v /etc/nagios/nagios.cfg;

#echo "*****Starting Apache Service*****"
service httpd start;

#echo "*****Starting Nagios Service*****"
service nagios start;
#echo "*****Nagios Installation has Finished*****"
