#!/bin/bash
#Script to create the database for Bolt CMS

echo Hello, I\'m Brian and I\'m here to help you create a MySQL DataBase for Bolt CMS.
echo I create DataBases since I\'m 12 years old.
echo Please let me know a few things about you.

read -p 'What name did you choose for your new database ? ' dbname
read -p 'What is the admin or root username ? ' mysqlroot
read -sp 'What is the password ? ' rootpwd

echo Thanks, that\'s should be very easy...

#Generates passwords
function randpw { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;}

mysqluser="usr_$dbname"
mysqlpwd=$(randpw);

#Create the new database and user for MySQL
mysql --user="$mysqlroot" --password="$rootpwd"  --execute="CREATE DATABASE $dbname character set UTF8 collate utf8_bin; CREATE USER '$mysqluser'@'localhost' IDENTIFIED BY '$mysqlpwd';GRANT ALL PRIVILEGES ON $dbname.* TO '$mysqluser'@'localhost';"

echo -e "\n\n\n#####################################"
echo -e "# Warning, please take note of that #"
echo -e "#####################################"
echo -e "One user has been created."
echo -e "\tUsername: $mysqluser\n\tPassword: $mysqlpwd"
echo -e "\n\nIt will not be shown a second time"
echo -e "\nUse this user to connect Bolt to the database"

echo -e "\n\n\nIt's all done !\nEnjoy  and see you !\n\n"
