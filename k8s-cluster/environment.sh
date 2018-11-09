#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

NEXUS_PORT="90"
JENKINS_PORT="8082"
GITLAB_PORT="8083"

DOCKER_REGISTRY_PORT="5000"

SECRET_TOKEN="{AQAAABAAAAAQockYoJutL7ZGpK6oePv79oGf7TaXymyHJ6CrQJLYBrk=}"

#Change to 'fa-nexus' if you want to provision Nexus data on FlashArray
TARGET_STORAGE="fa"
STORAGE_CLASS_NAME="pure-file"

if [[ $TARGET_STORAGE == "fa" ]]
then
    STORAGE_CLASS_NAME="pure-block"
fi

IMPORT_VOLUMES_COMMENT=
IMPORT_VOLUMES=0

if [[ $IMPORT_VOLUMES == 1 ]]
then
    IMPORT_VOLUMES_COMMENT="#"
fi

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

#Set  IP addresses of the Sonatype Nexus, Jenkins and GitLab services in Kubernetes
NEXUS_IP="10.21.236.108"
JENKINS_IP="10.21.236.110"
GITLAB_IP="10.21.236.109"

#Create and paste below your GitLab API Access Token (with 'api' scope) generated from http://<GITLAB_IP>:<GITLAB_PORT>/profile/personal_access_tokens
GITLAB_TOKEN="xw9uv738zjfSAknDbxsy"

#Create and paste below your Jenkins API  Token generated from http://<JENKINS_IP>:<JENKINS_PORT>/user/admin/configure
JENKINS_TOKEN="1153a29f846f730118b3baced5c5fb867d"

NEXUS_IP="10.21.236.87"
JENKINS_IP="10.21.236.89"
GITLAB_IP="10.21.236.88"