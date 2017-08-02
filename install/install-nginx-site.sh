#!/bin/bash
#Script to configure nginx for Bolt CMS

echo Hello, I\'m Brian and I\'m here to help you configure nginx for Bolt CMS.
echo -e "It's gonna be very quick I've juste one question"

read -p 'What is your domain name (without http and www, for instance : example.com) ? ' domain

echo -e "\n\nThank you very much, let me do that for you !"

curl -O https://raw.githubusercontent.com/symbiodyssey/bolt-affiliate-template/master/install/nginx-site-conf
sed -i -e "s/{{domain}}/$domain/g" nginx-site-conf
mv nginx-site-conf /etc/nginx/sites-available/$domain
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/$domain

systemctl reload nginx

echo -e "\n\nIt's already done !"
