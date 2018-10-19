#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

. environment.sh

bash ./configuration/nexus/config-docker-registry.sh ${NEXUS_IP}

bash ./configuration/nexus/create-and-push-docker-images.sh ${NS} ${NEXUS_IP}:5000 admin admin123

bash ./configuration/gitlab/createProjects.sh ${GITLAB_TOKEN} "http://${GITLAB_IP}:8080"

bash ./configuration/jenkins/importPipelines.sh ${JENKINS_TOKEN} "${JENKINS_IP}:8081" ${NEXUS_IP} ${GITLAB_IP}