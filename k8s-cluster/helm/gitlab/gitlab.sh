#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# read the yml template from a file and substitute the string 
# {{GITLAB_IP_ADDRESS}} with the value of the NEXUS_IP variable
template=`cat "$SCRIPTPATH/gitlab.yaml" | sed "s/{{GITLAB_IP_ADDRESS}}/$GITLAB_IP/g" | sed "s/{{GITLAB_PORT}}/$GITLAB_PORT/g"`
# Install GitLab component 
# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
kubectl create -f "$SCRIPTPATH/pvc.yaml" -n ${NS}
# Install GitLab's Helm chart
echo "$template" | helm install --name pure-gitlab "$SCRIPTPATH/gitlab-ce" --namespace ${NS} -f -

# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
#kubectl create -f pvc.yaml -n ${NS}

# Install GitLab's Helm chart
#helm install --name ps-gitlab -f values.yaml gitlab-ce --namespace ${NS} 
