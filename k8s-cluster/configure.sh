#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

. environment.sh

bash ./configuration/nexus/config-docker-registry.sh ${NEXUS_IP}

bash ./configuration/gitlab/createProjects.sh

bash ./configuration/nexus/create-and-push-docker-images.sh

bash ./configuration/jenkins/importPipelines.sh 