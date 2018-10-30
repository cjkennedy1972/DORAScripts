#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

#JENKINS_IP=$2
#JENKINS_PORT=$3
#NEXUS_IP=$4
#NEXUS_PORT=$5
#GITLAB_IP=$6
#GITLAB_PORT=$7
#DOCKER_REGISTRY_PORT=$7

## Check if Mac or Linux
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
#echo ${machine}

rp()
{
    if [ $machine = 'Mac' ]; then
        rp "$@"
    else
        sed -i "$@"
    fi
}

export -f rp
## Stage 1 Import
cp "$SCRIPTPATH/Build-Kernel-Stage-1.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_PORT}}/${NEXUS_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{DOCKER_REGISTRY_PORT}}/${DOCKER_REGISTRY_PORT}/g" "$SCRIPTPATH/temp.xml"
#sed "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml" > "$SCRIPTPATH/temp2.xml"
#sed "s/{{GITLAB_IP_ADDRESS}}/$GITLAB_IP/g" "$SCRIPTPATH/temp2.xml" > "$SCRIPTPATH/temp.xml"

#java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job Build-Kernel-Stage1 < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"

CRUMB=$(curl -s 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

curl -H $CRUMB -X POST 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/credentials/store/system/domain/_/createCredentials' \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "gitlab",
    "username": "root",
    "password": "admin123",
    "description": "GitLab credentials",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'

curl -H $CRUMB -X POST 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/credentials/store/system/domain/_/createCredentials' \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "nexus",
    "username": "admin",
    "password": "admin123",
    "description": "Nexus credentials",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'

## Stage 2 Import
cp "$SCRIPTPATH/Build-Kernel-Stage2-Stage3.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VM_TEMPLATE}}/${VM_TEMPLATE}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{MASTER_BUILD_NO}}/${MASTER_BUILD_NO}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_HOST}}/${VSPHERE_HOST}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_USER}}/${VSPHERE_USER}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_PASSWORD}}/${VSPHERE_PASSWORD}/g" "$SCRIPTPATH/temp.xml"

#java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job Build-Kernel_Stage2-Stage3 < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"

## Import WordPress pipeline definition
cp "$SCRIPTPATH/Build-Wordpress.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_PORT}}/${NEXUS_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{DOCKER_REGISTRY_PORT}}/${DOCKER_REGISTRY_PORT}/g" "$SCRIPTPATH/temp.xml"

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job Build-WordPress-Job < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"

## Import Wordpress CD Job
cp "$SCRIPTPATH/Build-WordPress-CD.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_PORT}}/${NEXUS_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{DOCKER_REGISTRY_PORT}}/${DOCKER_REGISTRY_PORT}/g" "$SCRIPTPATH/temp.xml"

rp "s/{{VM_TEMPLATE}}/${VM_TEMPLATE}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{MASTER_BUILD_NO}}/${MASTER_BUILD_NO}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_HOST}}/${VSPHERE_HOST}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_USER}}/${VSPHERE_USER}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_PASSWORD}}/${VSPHERE_PASSWORD}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VSPHERE_RESOURCE}}/${VSPHERE_RESOURCE}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VM_MEMORY}}/${VM_MEMORY}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{VM_CPU}}/${VM_CPU}/g" "$SCRIPTPATH/temp.xml"

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job Build-Wordpress-CD-Job < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"