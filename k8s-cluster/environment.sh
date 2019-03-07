#!/bin/bash
#Set Kubernetes namespace
NS="no-pure"
METAL_LB_NS="metallb-system"
NGINX_INGRESS_NS="ingress-nginx"
MONITORING_NS="monitoring"

if [ ! -z $1 ]
then
    NS=$1
fi

NEXUS_PORT="9090"
#JENKINS_PORT="9082"
JENKINS_PORT="8082"
GITLAB_PORT="9083"

DOCKER_REGISTRY_PORT="5000"

SECRET_TOKEN="{AQAAABAAAAAQockYoJutL7ZGpK6oePv79oGf7TaXymyHJ6CrQJLYBrk=}"
STORAGE_CLASS_NAME="pure-file" #FlashBlade storage class by default
TARGET_STORAGE="kontena" #"fa" for on-prem FlashArray deployment, "fb" for on-prem FlashBlade deployment, "kontena" for local storages
TARGET_DEPLOYMENT="onprem"
PV_ACCESS_MODE="ReadWriteMany"

if [[ $TARGET_STORAGE == "fa" ]]
then
    STORAGE_CLASS_NAME="pure-block"
    PV_ACCESS_MODE="ReadWriteOnce"
elif [ $TARGET_STORAGE == "fb" ]
then
    STORAGE_CLASS_NAME="pure-file"
     PV_ACCESS_MODE="ReadWriteMany"
else
    STORAGE_CLASS_NAME="kontena-storage-block"
    PV_ACCESS_MODE="ReadWriteOnce"
fi

IMPORT_VOLUMES_COMMENT="#"
IMPORT_VOLUMES=0

if [[ $IMPORT_VOLUMES == 1 ]]
then
    IMPORT_VOLUMES_COMMENT=""
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
NEXUS_IP="10.21.236.81"
JENKINS_IP="10.21.236.81"
GITLAB_IP="10.21.236.81"

#Set Fully Qualified Domain Names of the Sonatype Nexus, Jenkins and GitLab services in Kubernetes
NEXUS_FQDN="nexus2.puretec.purestorage.com"
JENKINS_FQDN="jenkins2.puretec.purestorage.com"
GITLAB_FQDN="git2.puretec.purestorage.com"
DOCKER_FQDN="docker2.puretec.purestorage.com"

## CIDR Block for the IPs available for LoadBalancer use
METAL_LB_IP_CIDR="10.21.236.95-10.21.236.96"

#Create and paste below your GitLab API Access Token (with 'api' scope) generated from http://<GITLAB_IP>:<GITLAB_PORT>/profile/personal_access_tokens
GITLAB_TOKEN="ynsD_sQthQYN-ZUMydja"

#Create and paste below your Jenkins API  Token generated from http://<JENKINS_IP>:<JENKINS_PORT>/user/admin/configure
#JENKINS_TOKEN="11a1a721d38e63428d5a9733e96361acf8"
JENKINS_TOKEN="111f9715834bf0377ccde813617bccf24a"

#NEXUS_IP="10.21.236.87"
#JENKINS_IP="10.21.236.89"
#GITLAB_IP="10.21.236.88"

## Enable this if you want to install Prometheus/ Grafana
ENABLE_MONITORING="true"

## Enable this if you want to install MetalLB + Nginx-Ingress
METAL_LB_NGINX_INGRESS="false"