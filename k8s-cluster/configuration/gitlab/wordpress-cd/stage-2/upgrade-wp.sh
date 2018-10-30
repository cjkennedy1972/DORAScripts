#!/bin/bash -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo $SCRIPTPATH

#download wordpress
echo 'Downloading Wordpress'
curl -O http://@@NEXUS_URL@@/repository/builds-store/wp_gid/wordpress-artifacts/1.0.0.@@WP_BUILD_NUMBER@@/wordpress-artifacts-1.0.0.@@WP_BUILD_NUMBER@@-wordpress-artifacts.tar.gz
#unzip wordpress
tar -zxvf wordpress-*.tar.gz

#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . /var/www/html
#move back to parent dir
cd /var/www/html

echo 'Setting correct permissions'
#create uploads folder and set permissions
chmod 775 wp-content/uploads

## Setup permissions
chown -R root:www-data /var/www/html
find /var/www/html -type d -exec chmod g+s {} \;
chmod g+w /var/www/html/wp-content
chmod -R g+w /var/www/html/wp-content/themes
chmod -R g+w /var/www/html/wp-content/plugins

echo "========================="
echo "Upgrade is complete."
echo "========================="
