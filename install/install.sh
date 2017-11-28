#!/bin/bash
#Script to install Bolt CMS

echo Hello, I\'m Brian and I\'m here to help you install Bolt CMS.
echo I\'m very curious and would like to ask you a few questions.

read -p 'What is your name ? ' name
echo -e "This is a beautiful name !\n\n"

read -p 'What is the title of your website ? ' title
echo Nice, I like it !

read -p 'What is your domain name (without http and www, for instance : example.com) ? ' domain
echo -e "\n\nOh wow ! I wish I've thought about it before you"
echo -e "\n\n"
read -p 'What is the name of your database ? ' mysqlname
read -p 'What is your username for MySQL ? ' mysqluser
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
php app/nut init
rm bolt-latest.tar.gz

#Edit app/config/config.yml with the correct entries
toreplace="database:"
dbconf="database:\\
    driver: mysql\\
    username: $mysqluser\\
    password: $mysqlpwd\\
    databasename: $mysqlname"

sed --in-place "/   driver: sqlite/d" app/config/config.yml
sed --in-place "/    databasename: bolt/d" app/config/config.yml
sed --in-place "s/${toreplace}/${dbconf}/g" app/config/config.yml

#Creation of two users
#Generation of two passwords one for the admin and one for the user
function randpw { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;}

adminpwd=$(randpw);
userpwd=$(randpw);

#Suglify the user's name to create a username
username=$(echo "$name" | iconv -t ascii//TRANSLIT | sed -r s/[~\^]+//g | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z);

#Create the users in Bolt
php app/nut  user:add admin Admin admin@$domain "$adminpwd" root
php app/nut  user:add "$username" "$name" "$username@$domain" "$userpwd" chief-editor

#Activate the users
mysql --user="$mysqluser" --password="$mysqlpwd" --database="$mysqlname"  --execute="update bolt_users set enabled=1 where id>0;"

#Change the ownership of some directories to make it work
chown -R root:www-data ./


#Change the rights
chmod a+r ./

for dir in app/cache/ app/database/ public/thumbs/ ; do
    find $dir -type d -print0 | xargs -0 chmod u+rwx,g+rwxs,o+rx-w
    find $dir -type f -print0 | xargs -0 chmod u+rw-x,g+rw-x,o+r-wx > /dev/null 2>&1
done

for dir in app/config/ extensions/ public/extensions/ public/files/ public/theme/ ; do
    find $dir -type d -print0 | xargs -0 chmod u+rwx,g+rwxs,o+rx-w
    find $dir -type f -print0 | xargs -0 chmod u+rw-x,g+rw-x,o+r-wx > /dev/null 2>&1
done

#Update database and clean the cache
php app/nut database:update
php app/nut cache:clear


echo -e "#####################################"
echo -e "# Warning, please take note of that #"
echo -e "#####################################"
echo -e "Two users have been created."
echo -e "First :\n\tUsername: admin\n\tPassword: $adminpwd"
echo -e "\nSecond ; \n\tUsername: $username\n\tPassword: $userpwd"
echo -e "\n\nIt will not be shown a second time"
echo -e "\nUse only the second user to connect to Bolt and edit your website\nUse the first user only if you not what you do"

echo -e "\n\n\nIt's all done !\nEnjoy  and see you !\n\n"
