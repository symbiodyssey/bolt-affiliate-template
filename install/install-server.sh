#!/bin/bash
#Script to install the required softwares on Debian

apt-get --assume-yes update
systemctl stop apache2.service
apt-get remove apache2
apt-get --assume-yes install curl
apt-get --assume-yes install nano
apt-get --assume-yes install nginx
apt-get --assume-yes install mysql-server
apt-get --assume-yes install php5-fpm php5-mysql

mysql_secure_installation

sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
systemctl restart php5-fpm
