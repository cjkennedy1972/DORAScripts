#!/bin/bash -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo $SCRIPTPATH

# Install HA-Proxy  
echo 'Installing Ha-Proxy'
apt-get -y install haproxy
echo 'Verifying Ha-Proxy installation'
haproxy -v

## Add Ha-Proxy config file
echo 'Copying config files'
cp files/haproxy.cfg /etc/haproxy/haproxy.cfg

#We can verify the configuration file is valid with following command. 
# If there are any errors, they will be displayed so that we can go in and fix them:
haproxy -f /etc/haproxy/haproxy.cfg -c

#restart HA-Proxy service
service haproxy restart

echo "========================="
echo "Installation is complete."
echo "========================="