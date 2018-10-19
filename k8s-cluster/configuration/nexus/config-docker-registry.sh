#!/bin/bash

NEXUS_IP="1.1.1.1"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -z $1 ]
then
    NEXUS_IP=$1
else
    echo "Aborting, the NEXUS_IP parameter is missing"
    exit 0
fi
#echo $NEXUS_IP

ansible-playbook -i ../kube-ansible/inventory "$SCRIPTPATH/add-docker-insecure-registry.yml" --check --extra-vars "docker_insecure_registry=$NEXUS_IP:5000" 