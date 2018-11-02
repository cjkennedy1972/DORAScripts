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

#Set  IP addresses of the Sonatype Nexus, Jenkins and GitLab services in Kubernetes
NEXUS_IP="10.21.236.108"
JENKINS_IP="10.21.236.110"
GITLAB_IP="10.21.236.109"

#Create and paste below your GitLab API Access Token (with 'api' scope) generated from http://<GITLAB_IP>:<GITLAB_PORT>/profile/personal_access_tokens
GITLAB_TOKEN="vQWTRjFu_hSzaE57g-By"

#Create and paste below your Jenkins API  Token generated from http://<JENKINS_IP>:<JENKINS_PORT>/user/admin/configure
JENKINS_TOKEN="11be5214e0c29732b4a8f7e4938ec4f0bb"

#NEXUS_IP="10.21.236.87"
#JENKINS_IP="10.21.236.89"
#GITLAB_IP="10.21.236.88"