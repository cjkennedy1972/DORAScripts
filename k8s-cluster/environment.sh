#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

#Set environment variables
NEXUS_IP="10.21.236.108"
JENKINS_IP="10.21.236.109"
GITLAB_IP="10.21.236.109"

#Set API Access Token in GitLab and Jenkins
GITLAB_TOKEN="MxU74j2qCCo5BQ-EvrBr"
JENKINS_TOKEN="11320965f153e505cf1edee79c7aa0ad20"