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

#Create and paste below your GitLab API Access Token (with 'api' scope) generated from http://<GITLAB_IP>:<GITLAB_PORT>/profile/personal_access_tokens
GITLAB_TOKEN="7uJHVHETcNnuM6nsKQE9"

#Create and paste below your Jenkins API  Token generated from http://<JENKINS_IP>:<JENKINS_PORT>/user/admin/configure
JENKINS_TOKEN="11241e9d140c949f33f7d1727c2e2bcf52"

#
SECRET_TOKEN="{AQAAABAAAAAQockYoJutL7ZGpK6oePv79oGf7TaXymyHJ6CrQJLYBrk=}"

## Environment variables/ Params for CD jobs - Build No, vSphere creds
## All build  which satsify (build number % MASTER_BUILD_NO == 0 ) will launch Stage 2 + 3 VMs
MASTER_BUILD_NO="1"
## vSphere Credentials
VSPHERE_HOST="10.21.236.254"
VSPHERE_USER="Administrator@vsphere.local"
VSPHERE_PASSWORD="Osmium77$"
VSPHERE_RESOURCE="DevOps-Cluster"
## Base VM Template name in vSphere
VM_TEMPLATE="pure-wp-vm"
VM_MEMORY="512"
VM_CPU="1"

NEXUS_IP="10.21.236.86"
JENKINS_IP="10.21.236.89"
GITLAB_IP="10.21.236.87"