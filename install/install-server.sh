#!/bin/bash
#Script to install the required softwares on Debian 9 stretch

apt-get --assume-yes update
apt-get --assume-yes install curl nginx mariadb-server composer php7.0-cli php7.0-fpm php7.0-mysql php7.0-gd php7.0-xml php7.0-intl php7.0-curl php7.0-zip php7.0-mbstring git

mysql_secure_installation