#!/bin/bash
#Script to install the required softwares on Debian

apt-get --assume-yes update
apt-get --assume-yes install curl
apt-get --assume-yes install nginx
apt-get --assume-yes install mysql-server
apt-get --assume-yes install php5-fpm php5-mysql
