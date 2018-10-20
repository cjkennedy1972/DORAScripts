#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

. environment.sh

#bash ./configuration/nexus/config-docker-registry.sh ${NEXUS_IP}

bash ./configuration/gitlab/createProjects.sh ${GITLAB_TOKEN} "http://${GITLAB_IP}:${GITLAB_PORT}"

bash ./configuration/nexus/create-and-push-docker-images.sh ${NS} ${NEXUS_IP}:${DOCKER_REGISTRY_PORT} admin admin123

bash ./configuration/jenkins/importPipelines.sh ${JENKINS_TOKEN} 