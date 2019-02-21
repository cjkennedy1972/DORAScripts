#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ingress=`cat "$SCRIPTPATH/ingress.yaml" | sed "s/{{NS}}/${NS}/g" | sed "s/{{JENKINS_PORT}}/$JENKINS_PORT/g" | sed "s/{{DOCKER_REGISTRY_PORT}}/$DOCKER_REGISTRY_PORT/g" | sed  "s/{{NEXUS_PORT}}/$NEXUS_PORT/g" | sed  "s/{{GITLAB_PORT}}/$GITLAB_PORT/g"`

echo "$controller" | kubectl create  -f -
echo "$ingress" | kubectl create -f -
kubectl create -f "$SCRIPTPATH/nginx-ingress-controller.yaml"
kubectl create -f "$SCRIPTPATH/nginx-ingress-service.yaml.yaml"
