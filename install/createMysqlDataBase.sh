#!/bin/bash
#Script to create the database for Bolt CMS

echo Hello, I'm Brian and I'm here to help you create a MySQL DataBase for Bolt CMS.
echo I create DataBases since I'm 12 years old.
echo Please let me know a few things about you.
read -p 'What name did you choose for your new database ? ' dbname
read -p 'What is the admin or root username ? ' mysqlroot
read -sp 'What is the password ? ' rootpwd
read -p 'What is the new username ? ' mysqluser
read -sp 'What is the new password for this user ? ' mysqlpwd
echo Thanks, that's should be very easy...

#Create the new database and user for MySQL
mysql --user="$mysqlroot" --password="$rootpwd"  --execute="CREATE DATABASE $dbname character set UTF8 collate utf8_bin; CREATE USER '$mysqluser'@'localhost' IDENTIFIED BY 'mysqlpwd';GRANT ALL PRIVILEGES ON $dbname.* TO '$mysqluser'@'localhost';"

echo It's all done !
echo See you soon !
