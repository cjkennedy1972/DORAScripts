#!/bin/bash
uname -r
wget -q http://0.0.0.0/repository/kernel/Kernel/kl_artId1/1.0.0.6/kl_artId1-1.0.0.6-kern-package.tar.gz
tar -xvf kl_artId1-1.0.0.6-kern-package.tar.gz
dpkg -i *.deb
uname -r
# shutdown -r
