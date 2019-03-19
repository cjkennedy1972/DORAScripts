#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ingress=`cat "$SCRIPTPATH/ingress.yaml" | sed "s/{{NS}}/${NS}/g" | sed "s/{{JENKINS_PORT}}/$JENKINS_PORT/g" | sed "s/{{DOCKER_REGISTRY_PORT}}/$DOCKER_REGISTRY_PORT/g" | sed  "s/{{NEXUS_PORT}}/$NEXUS_PORT/g" | sed  "s/{{GITLAB_PORT}}/$GITLAB_PORT/g" | sed "s/{{JENKINS_FQDN}}/$JENKINS_FQDN/g" | sed "s/{{DOCKER_FQDN}}/$DOCKER_FQDN/g" | sed  "s/{{NEXUS_FQDN}}/$NEXUS_FQDN/g" | sed  "s/{{GITLAB_FQDN}}/$GITLAB_FQDN/g"`

echo "$ingress" | kubectl delete -f -
