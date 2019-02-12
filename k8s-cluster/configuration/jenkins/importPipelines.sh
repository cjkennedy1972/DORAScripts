#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

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
        sed -i '' "$@"
    else
        sed -i "$@"
    fi
}

export -f rp

#Create the 'gitlab' and 'nexus' Credentials in Jenkins to allow Jenkins pipelines to authenticate againsts GitLab and Sonatype Nexus
CRUMB=$(curl -s 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

curl -H $CRUMB -X POST 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/credentials/store/system/domain/_/createCredentials' \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "git-user",
    "username": "root",
    "password": "admin123",
    "description": "Git user credentials",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'

curl -H $CRUMB -X POST 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/credentials/store/system/domain/_/createCredentials' \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "git-user-aws",
    "username": "<AWS_CODE_COMMIT_HTTPS_USERNAME>",
    "password": "<AWS_CODE_COMMIT_HTTPS_PASSWORD>",
    "description": "AWS CodeCommit credentials",
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

## Import WordPress CI pipeline job definition
cp "$SCRIPTPATH/WordPress-CI-Job.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{NEXUS_PORT}}/${NEXUS_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{SECRET_TOKEN}}/${SECRET_TOKEN}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{DOCKER_REGISTRY_PORT}}/${DOCKER_REGISTRY_PORT}/g" "$SCRIPTPATH/temp.xml"

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job WordPress-CI-Job < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"

## Import WordPress CD pipeline job definition
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

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job WordPress-CD-Job < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"

## Import WordPress AWS-CodeCommit pipeline job definition
cp "$SCRIPTPATH/AWS-Code-Commit.xml" "$SCRIPTPATH/temp.xml"
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

#java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job AWS-CodeCommit < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"