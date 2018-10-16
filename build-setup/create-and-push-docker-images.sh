#!/bin/bash

if [ $# -lt 1 ] 
then
  echo "Please pass 'Nexus server IP' as argument Ex.: ./create-and-push-docker-images.sh 10.21.236.86"
  exit
fi

nexus_server_ip=$1

#Create and push the base image for JNLP Slave
docker build -f dockerfile-jnlp-slave-sudo -t "$nexus_server_ip":5000/jnlp-slave-sudo .
docker push "$nexus_server_ip":5000/jnlp-slave-sudo

#Create and push the base image for build-kernel
docker build -f dockerfile-build-kernel -t "$nexus_server_ip":5000/build-kernel .
docker push "$nexus_server_ip":5000/build-kernel

#Create and push the base image for dockerfile-purestorage-vagrant
docker build -f dockerfile-build-kernel -t "$nexus_server_ip":5000/purestorage/vagrant .
docker push "$nexus_server_ip":5000/purestorage/vagrant