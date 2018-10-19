#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

#Set environment variables
NEXUS_IP="10.21.236.108"
JENKINS_IP="10.21.236.110"
GITLAB_IP="10.21.236.109"

NEXUS_PORT="90"
JENKINS_PORT="8082"
GITLAB_PORT="8083"

DOCKER_REGISTRY_PORT="5000"

#Set API Access Token in GitLab and Jenkins
GITLAB_TOKEN="yBVW7G_F54BXRsCRazZi"
JENKINS_TOKEN="115359d190ac7603bd5c1f800450733283"