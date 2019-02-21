#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ingress=`cat "$SCRIPTPATH/ingress.yaml" | sed "s/{{NS}}/${NS}/g" | sed "s/{{JENKINS_PORT}}/$JENKINS_PORT/g" | sed "s/{{DOCKER_REGISTRY_PORT}}/$DOCKER_REGISTRY_PORT/g" | sed  "s/{{NEXUS_PORT}}/$NEXUS_PORT/g" | sed  "s/{{GITLAB_PORT}}/$GITLAB_PORT/g"`

echo "$controller" | kubectl create  -f -
echo "$ingress" | kubectl create -f -
kubectl create -f "$SCRIPTPATH/nginx-ingress-controller.yaml"
kubectl create -f "$SCRIPTPATH/nginx-ingress-service.yaml.yaml"

DOCKER_REGISTRY=${NEXUS_IP}:${DOCKER_REGISTRY_PORT}
kubectl create -n ${NS} secret docker-registry jenkins-pull --docker-server=$DOCKER_REGISTRY --docker-username=admin --docker-password=admin123 --docker-email=pure@purestorage.com

