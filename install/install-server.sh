#!/bin/bash
#Script to install the required softwares on Debian

apt-get --assume-yes update
systemctl stop apache2.service
apt-get remove apache2
apt-get --assume-yes install curl
apt-get --assume-yes install nano
apt-get --assume-yes install nginx
apt-get --assume-yes install mysql-server
apt-get --assume-yes install php5-cli php5-fpm php5-mysql php5-gd git

mysql_secure_installation

sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
systemctl restart php5-fpm

#Install composer
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm /tmp/composer-setup.php

wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/symbiodyssey/bolt-affiliate-template/master/install/nginx.conf
systemctl reload nginx
