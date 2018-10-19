#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

#Set environment variables
NEXUS_IP="10.21.236.87"
JENKINS_IP="10.21.236.88"
GITLAB_IP="10.21.236.89"

#Set API Access Token in GitLab and Jenkins
GITLAB_TOKEN="MxU74j2qCCo5BQ-EvrBr"
JENKINS_TOKEN="11320965f153e505cf1edee79c7aa0ad20"

bash ./configuration/nexus/config-docker-registry.sh ${NEXUS_IP}

bash ./configuration/nexus/create-and-push-docker-images.sh ${NS} ${NEXUS_IP}:5000 admin admin123

bash ./configuration/gitlab/createProjects.sh ${GITLAB_TOKEN} "http://${GITLAB_IP}:8080"

bash ./configuration/jenkins/importPipelines.sh ${JENKINS_TOKEN} "${JENKINS_IP}:8081" ${NEXUS_IP} ${GITLAB_IP}