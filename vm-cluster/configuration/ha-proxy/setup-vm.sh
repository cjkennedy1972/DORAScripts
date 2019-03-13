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

## Install and configure Ha-Proxy
cd $SCRIPTPATH
bash ./install-ha-proxy.sh

