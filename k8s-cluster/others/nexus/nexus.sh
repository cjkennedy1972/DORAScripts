#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Install Nexus Repository Manager resources 
template=`cat "$SCRIPTPATH/service.yaml" | sed "s/{{NEXUS_IP_ADDRESS}}/$NEXUS_IP/g" | sed "s/{{DOCKER_REGISTRY_PORT}}/$DOCKER_REGISTRY_PORT/g" | sed  "s/{{NEXUS_PORT}}/$NEXUS_PORT/g"`
deploy=`cat "$SCRIPTPATH/deployment.yaml" | sed "s/{{NEXUS_CLAIM_NAME}}/$NEXUS_CLAIM_NAME/g"`

claim=`cat "$SCRIPTPATH/nexus-claim.yaml" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{IMPORT_VOLUMES_COMMENT}}/$IMPORT_VOLUMES_COMMENT/g" `

echo "$claim" | kubectl create -n ${NS} -f -

echo "$template" | kubectl create -n ${NS} -f -
echo "$deploy" | kubectl create -n ${NS} -f -
#kubectl create -f "$SCRIPTPATH/deployment.yaml" -n ${NS}

DOCKER_REGISTRY=${NEXUS_IP}:${DOCKER_REGISTRY_PORT}
kubectl create -n ${NS} secret docker-registry jenkins-pull --docker-server=$DOCKER_REGISTRY --docker-username=admin --docker-password=admin123 --docker-email=pure@purestorage.com

