#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh


# Install GitLab component 
# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
claim=`cat "$SCRIPTPATH/pvc.yaml" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{IMPORT_VOLUMES_COMMENT}}/$IMPORT_VOLUMES_COMMENT/g" `
echo "$claim" | kubectl create -n ${NS} -f -

# Install GitLab's Helm chart
# read the yml template from a file and substitute the string 
# {{GITLAB_IP_ADDRESS}} with the value of the GITLAB_IP variable
template=`cat "$SCRIPTPATH/gitlab.yaml" | sed "s/{{GITLAB_IP_ADDRESS}}/$GITLAB_IP/g" | sed "s/{{GITLAB_PORT}}/$GITLAB_PORT/g"`
echo "$template" | helm install --name pure-gitlab "$SCRIPTPATH/gitlab-ce" --namespace ${NS} -f -
