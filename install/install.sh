#!/bin/bash
#Script to install Bolt CMS

echo Hello, I\'m Brian and I\'m here to help you install Bolt CMS.
echo I\'m very curious and would like to ask you a few questions.

read -p 'What is the title of your website ? ' title
echo Nice, I like it !

read -p 'What is your domain name (without http and www, for instance : example.com) ? ' domain
echo -e "\n\nOh wow ! I wish I've thought about it before you"
echo -e "\n\n"
read -p 'What is your username for MySQL ? ' mysqlroot
read -sp 'What is the password of this user ? ' mysqlpwd

echo -e "\n\nThanks, now I know a new secret :P"
echo But no worries you can trust me !

echo -e "\n\nLet me ask you a last question"
read -p "Where would you like to install Bolt, if you don't know, type /var/www ? " bolt_dir

echo -e "\n\nThat shoud be enough, let me install it for you !"
#Create directory with first parameter and go in
mkdir $bolt_dir/$domain
cd $bolt_dir/$domain

#Get the latest version of Bolt
curl -O https://bolt.cm/distribution/bolt-latest.tar.gz
tar -xzf bolt-latest.tar.gz --strip-components=1
php app/nut setup:sync
rm bolt-latest.tar.gz

chown -R www-data:www-data app/cache
chown -R www-data:www-data app/config
chown -R www-data:www-data extensions
chown -R www-data:www-data public/files
chown -R www-data:www-data public/thumbs

mkdir tmp
cd tmp

curl -LO https://github.com/symbiodyssey/bolt-affiliate-template/archive/master.tar.gz
tar -xzf bolt-affiliate-template-master.tar.gz --strip-components=1
mv bolt-affiliate-template-master/template ../public/theme/affiliatews
cd ..
rm -R tmp

echo -e "\n\n\nIt's all done !\nEnjoy  and see you !\n\n"

