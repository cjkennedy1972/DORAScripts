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
# cp "$SCRIPTPATH/AWS-Code-Commit.xml" "$SCRIPTPATH/temp.xml"
# rp "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{NEXUS_PORT}}/${NEXUS_PORT}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{DOCKER_REGISTRY_PORT}}/${DOCKER_REGISTRY_PORT}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VM_TEMPLATE}}/${VM_TEMPLATE}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{MASTER_BUILD_NO}}/${MASTER_BUILD_NO}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VSPHERE_HOST}}/${VSPHERE_HOST}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VSPHERE_USER}}/${VSPHERE_USER}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VSPHERE_PASSWORD}}/${VSPHERE_PASSWORD}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VSPHERE_RESOURCE}}/${VSPHERE_RESOURCE}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VM_MEMORY}}/${VM_MEMORY}/g" "$SCRIPTPATH/temp.xml"
# rp "s/{{VM_CPU}}/${VM_CPU}/g" "$SCRIPTPATH/temp.xml"

# #java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job AWS-CodeCommit < "$SCRIPTPATH/temp.xml"

# rm "$SCRIPTPATH/temp.xml"

# Create credentials for SSH plugin used by the HA-Proxy-Deploy job
curl -H $CRUMB -X POST 'http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/credentials/store/system/domain/_/createCredentials' \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "HA-Proxy-VM-Key",
    "username": "root",
    "password": "",
    "privateKeySource": {
      "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource",
      "privateKey": "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEAthn+WbmjnqEmkkdOJTpoOaBsOqfO4K0m3G1kWThc9q+Wp10n\nvcOTjorZyBbwA8bu2BpiQP5FbxIVvUIu32ATdePCt+pwcZUJ7pLRHDA+Ym6+uK8p\nE+rPzUNpthHq2pCbq48/az6CwhqOg6FyADNX7uhFNp9cR7Yy7EfubseqROWxbsxI\nMLSSMT1qPRnRPWCiel1YyQu73LsljGA4rowv+LpCmqHT3R9UcumvpZGmFEBlxqFi\n9QhCdetOyBahsgxPjbC/hkn2kFZ5z3GkS4vwt0lLnSJ99PAtf+4dTKRkKkjkJNeM\ncxCCHepwhW9IGn2hbIq3mc/uC/Xv1Te2lpJmsQIDAQABAoIBAB6gNITGkdwF4kTL\ntTrRneHDNzCONF7ZACYmR7AxqIDcewvewOZLVC+u7n2WTft0o4q4tTmVCfxqIDna\nPaPXtq4nBgKEbTDNDgSPsJd7DaLkWTMaUmBFJ3mwEsFKNiNYGrY5u0LAGqGmcb11\nk4SxHeLSMYHEP3LYE6xlVJZRAjPf3Mz7/WiS7wM+oUBNfoEb6aM9RGnVgtQLEIYc\naJR6gUwTRtGXrB0OSHzCBcc7j6H2Dc0FyGLKfcCn7AJUf4LiBXwnPVUM/KfF3lk5\nsuh0whM0J0h6Xp5lDrSPhHSmIcWdUIa8BiD4eDSlzLGpzddyxC0EK8SwWRa7eQH2\nS97PlAECgYEA4S3JINuyfEUrn67earOtGLk9Hql/9nNbU9neuHJIA5s9q79VdZNq\n4ETi4vFbQGaeEzf5JBlT9jE2diznyK8jhRSOZE4H406vA/j1cMF3YQ0HENVwZarn\nRKG4JQkyHiiQOoiA023eN23v0YUBxoF0oDLG2434/9L7S/OQKYISANECgYEAzwbJ\n9iAvA80v1aLW843HirQBWBsifokOsyaRsmIxXX+dsG6Knx5m44Cbe1Ydbpu17lWH\nvhQTyq+CJqP/SLKajmfuEA2DrEzKY8nxHooKp4rl3uHbRddlviP6NUxaA/UDugHf\nCnmXt3/yag7ozYTEit6d+4VnN6OTGnzqQsbYf+ECgYEA0Z/gBxi/NfTmwYb3Q3n1\nAHkhrvO4TmPhd1PxhN/OrpzMcqByHDyaWCGI3iA2BOQC8H1BEBwMD7qMqsLvG+H/\nPRp/3FzP9wn+38HaK5fPXKfWFhO8yMiq9zddyAyhfXXhnrwIwcsb/Zn4kaIynutQ\n+PmMKkQms3Fjw7cAU8PkoqECgYAan5jhWgoxxvVb1/EkqRr8L2Hs3rB07VNCnrcl\n5ZLLn1m8Erso81Pv9d4I4m4uhz/CQqWOQC67Zg6qwXRW+QD/R0ZKMjK4ubddVd74\nOnBcU3R0UT9NoAGpjh7jM8pvr9am2Q7B3hkws/eMxBYUN/q+kRpn+iPn99U3FtFZ\nfRDigQKBgAoI9kBS5pa4jUzSXoEDutBJTqr7OdNbthELoxkEoKPAf7Y4AA8OQ+Sb\ngQPm/vSAD5wJnuigBW9+NOeXwkpokYr/QNjfqo3EBU39oL/wYgAqO9k5/nDpAOGX\n+9KH/lvRML6nwWISFHEJjQKx0dTAH/COiUNRYScci8GzoME9m/rh\n-----END RSA PRIVATE KEY-----"
    },
    "description": "Private Key Authentication for Ha-Proxy-VM",
    "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
  }
}'

## Import HA-Proxy-Deploy pipeline job definition
cp "$SCRIPTPATH/HA-Proxy-Deploy-Job.xml" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{GITLAB_PORT}}/${GITLAB_PORT}/g" "$SCRIPTPATH/temp.xml"
rp "s/{{HA_PROXY_VM_IP}}/${HA_PROXY_VM_IP}/g" "$SCRIPTPATH/temp.xml"

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN create-job HA-Proxy-Deployment < "$SCRIPTPATH/temp.xml"

rm "$SCRIPTPATH/temp.xml"
