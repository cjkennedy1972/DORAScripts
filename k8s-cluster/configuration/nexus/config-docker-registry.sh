#!/bin/bash

NEXUS_IP="1.1.1.1"
DOCKER_REGISTRY_PORT="5000"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -z $1 ]
then
    NEXUS_IP=$1
else
    echo "Aborting, the NEXUS_IP parameter is missing"
    exit 0
fi
if [ ! -z $2 ]
then
    DOCKER_REGISTRY_PORT=$2
fi
#echo $NEXUS_IP

ansible-playbook -i ../kube-ansible/inventory "$SCRIPTPATH/add-docker-insecure-registry.yml" --check --extra-vars "docker_insecure_registry=$NEXUS_IP:$DOCKER_REGISTRY_PORT" 