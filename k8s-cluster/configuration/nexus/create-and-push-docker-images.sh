#!/bin/sh

. environment.sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

docker_repo_url=${NEXUS_IP}:${DOCKER_REGISTRY_PORT}
docker_user="admin"
docker_pass="admin123"


# Docker login
docker login "$docker_repo_url" -u "$docker_user" -p "$docker_pass"

#Create and push the base image for JNLP Slave
docker build -f "$SCRIPTPATH/dockerfile-jnlp-slave-sudo" -t "$docker_repo_url"/jnlp-slave-sudo .
docker push "$docker_repo_url"/jnlp-slave-sudo

#Create and push the base image for build-kernel
#docker build -f "$SCRIPTPATH/dockerfile-build-kernel" -t "$docker_repo_url"/build-kernel .
#docker push "$docker_repo_url"/build-kernel

#Create and push the base image for dockerfile-purestorage-vagrant
docker build -f "$SCRIPTPATH/dockerfile-purestorage-vagrant" -t "$docker_repo_url"/purestorage/vagrant .
docker push "$docker_repo_url"/purestorage/vagrant

#Create and push the base image for dockerfile-purestorage-vagrant
docker build -f "$SCRIPTPATH/dockerfile-wordpress" -t "$docker_repo_url"/build-wordpress .
docker push "$docker_repo_url"/build-wordpress

#kubectl create -n ${NS} secret docker-registry jenkins-pull --docker-server=$docker_repo_url --docker-username=admin --docker-password=admin123 --docker-email=pure@pure.pure
