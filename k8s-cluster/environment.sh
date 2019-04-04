#!/bin/bash
#Set Kubernetes namespace
NS="pure"

if [ ! -z $1 ]
then
    NS=$1
fi

DOCKER_REGISTRY_PORT="5000"

SECRET_TOKEN="{AQAAABAAAAAQockYoJutL7ZGpK6oePv79oGf7TaXymyHJ6CrQJLYBrk=}"
STORAGE_CLASS_NAME="pure-file" #FlashBlade storage class by default
TARGET_STORAGE="fb" #"fa" for on-prem FlashArray deployment, "fb" for on-prem FlashBlade deployment, "kontena" for local storages
TARGET_DEPLOYMENT="onprem"
PV_ACCESS_MODE="ReadWriteMany"

if [ $TARGET_STORAGE == "fa" ]
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


HA_PROXY_VM_IP="192.168.8.56"

#Sonatype Nexus Settings
NEXUS_FQDN="nexus.puretec.purestorage.com"
NEXUS_IP="10.21.236.88"
NEXUS_PORT="9090"

#Jenkins Settings
JENKINS_IP="10.21.236.86"
JENKINS_PORT="9081"
JENKINS_FQDN="jenkins.puretec.purestorage.com"

DOCKER_FQDN="docker.puretec.purestorage.com"

## CIDR Block for the IPs available for MetalLB LoadBalancer use
METAL_LB_IP_CIDR="10.21.236.96-10.21.236.107"

## GitLab settings
# If using MetalLB, update after running install.sh and before running configure.sh
GITLAB_IP="10.21.236.89"
GITLAB_PORT="8181"
GITLAB_DOMAIN="puretec.purestorage.com"
GITLAB_HTTP_PREFIX="http" #replace with "http" if using HTTP
GITLAB_SUFFIX="dev" #if non-empty, creates a GitLab instance accessible at GITLAB_HTTP_PREFIX://gitlab-GITLAB_SUFFIX.GITLAB_DOMAIN (for instance, http://gitlab-staging.puretec.purestorage.com). Otherwise, GitLab is available at GITLAB_HTTP_PREFIX://gitlab.GITLAB_DOMAIN
#GITLAB_FQDN="git.puretec.purestorage.com"

#Create and paste below your GitLab API Access Token (with 'api' scope) generated from http://<GITLAB_IP>:<GITLAB_PORT>/profile/personal_access_tokens
GITLAB_TOKEN="oVvsJqeV-ybCe2uMU7bP"
#Create and paste below your Jenkins API  Token generated from http://<JENKINS_IP>:<JENKINS_PORT>/user/admin/configure
JENKINS_TOKEN="11723a39ff9d413775c52f2ba2e3dfff66"

## Grafana settings
GRAFANA_HOSTNAME="grafana.puretec.purestorage.com"

## Enable this if you want to install or uninstall Prometheus/Grafana
ENABLE_MONITORING="true"

## Enable this if you want to install MetalLB + NGINX Ingress
METAL_LB_NGINX_INGRESS="true"

## If set to true, will delete MetalLB (from metallb-system namespace) and NGINX Ingress (from ingress-nginx namespace)
UNINSTALL_PREREQUISITES="false"