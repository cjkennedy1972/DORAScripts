#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo $SCRIPTPATH

## Setup root ssh key
dir=$(pwd)
cd /root
mkdir .ssh
chmod 700 .ssh
cd .ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2Gf5ZuaOeoSaSR04lOmg5oGw6p87grSbcbWRZOFz2r5anXSe9w5OOitnIFvADxu7YGmJA/kVvEhW9Qi7fYBN148K36nBxlQnuktEcMD5ibr64rykT6s/NQ2m2EerakJurjz9rPoLCGo6DoXIAM1fu6EU2n1xHtjLsR+5ux6pE5bFuzEgwtJIxPWo9GdE9YKJ6XVjJC7vcuyWMYDiujC/4ukKaodPdH1Ry6a+lkaYUQGXGoWL1CEJ1607IFqGyDE+NsL+GSfaQVnnPcaRLi/C3SUudIn308C1/7h1MpGQqSOQk14xzEIId6nCFb0gafaFsireZz+4L9e/VN7aWkmax omaster@omaster-VirtualBox" > authorized_keys
chmod 600 authorized_keys

## Install MySQL
apt-get update
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install mysql-server -y
systemctl start mysql
systemctl enable mysql

## Move MySQL Data directory to a different folder i.e. /mnt/data/mysql
systemctl stop mysql
rsync -av /var/lib/mysql /mnt/data/
mv /var/lib/mysql /var/lib/mysql.bak
sed -i 's#/var/lib/mysql#/mnt/data/mysql#g' /etc/mysql/mysql.conf.d/mysqld.cnf
echo "alias /var/lib/mysql/ -> /mnt/data/mysql/," >> /etc/apparmor.d/tunables/alias
systemctl restart apparmor
mkdir /var/lib/mysql/mysql -p
systemctl start mysql
rm -Rf /var/lib/mysql.bak
systemctl restart mysql

## Install PHP and Apache Server
apt-get install php -y
apt-get install php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip} -y
apt-get install libapache2-mod-php  -y
apt-get install php-curl php-xml php-xmlrpc apache2 -y
chown -R www-data:www-data /var/www
a2enmod rewrite
systemctl restart apache2

## Install and configure WordPress
cd $SCRIPTPATH
bash ./install-wp.sh

