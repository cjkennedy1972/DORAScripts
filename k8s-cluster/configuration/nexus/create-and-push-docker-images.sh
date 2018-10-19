#!/bin/sh

if [ $# -lt 1 ] 
then
  echo "Please pass Docker repository and Docker repo user, pass as arguments  Ex.: sh create-and-push-docker-images.sh 10.21.236.86:5000 admin admin123"
  exit
fi

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

docker_repo_url=$1
docker_user=$2
docker_pass=$3


# Docker login
docker login "$docker_repo_url" -u "$docker_user" -p "$docker_pass"

#Create and push the base image for JNLP Slave
docker build -f "$SCRIPTPATH/dockerfile-jnlp-slave-sudo" -t "$docker_repo_url"/jnlp-slave-sudo .
docker push "$docker_repo_url"/jnlp-slave-sudo

#Create and push the base image for build-kernel
docker build -f "$SCRIPTPATH/dockerfile-build-kernel" -t "$docker_repo_url"/build-kernel .
docker push "$docker_repo_url"/build-kernel

#Create and push the base image for dockerfile-purestorage-vagrant
docker build -f "$SCRIPTPATH/dockerfile-build-kernel" -t "$docker_repo_url"/purestorage/vagrant .
docker push "$docker_repo_url"/purestorage/vagrant