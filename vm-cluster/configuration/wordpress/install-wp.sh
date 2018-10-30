#!/bin/bash -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo $SCRIPTPATH

# Create and Import DB
echo 'Restoring Wordpress DB'
mysql -u root --password=root < db/create-db.sql
mysql -u root --password=root wordpress < db/wordpress.sql

#download wordpress
echo 'Downloading Wordpress'
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz

## Add WP config
echo 'Copying WP config files'
cp files/wp-config.php wordpress
cp files/.htaccess wordpress

#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . /var/www/html
#move back to parent dir
cd /var/www/html

echo 'Setting correct permissions'
#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 775 wp-content/uploads

## Setup permissions
chown -R root:www-data /var/www/html
find /var/www/html -type d -exec chmod g+s {} \;
chmod g+w /var/www/html/wp-content
chmod -R g+w /var/www/html/wp-content/themes
chmod -R g+w /var/www/html/wp-content/plugins
rm /var/www/html/index.html

# Install plugin 'Application Passwords'
echo 'Installing WP Plugins'
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp plugin install application-passwords --path=/var/www/html --allow-root
wp plugin activate application-passwords --path=/var/www/html --allow-root

wp plugin install wp-basic-auth --path=/var/www/html --allow-root
wp plugin activate wp-basic-auth --path=/var/www/html --allow-root

cd $SCRIPTPATH
# Generate Load
php files/blog.php

echo "========================="
echo "Installation is complete."
echo "========================="