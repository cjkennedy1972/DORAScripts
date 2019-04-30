#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# reads the yml template from a file and substitutes: 
# {{JENKINS_IP_ADDRESS}} with the value of the JENKINS_IP variable
# {{JENKINS_PORT}} with the value of the JENKINS_PORT variable
template=`cat "$SCRIPTPATH/jenkins.yaml" | sed "s/{{JENKINS_IP_ADDRESS}}/$JENKINS_IP/g" | sed "s/{{JENKINS_PORT}}/$JENKINS_PORT/g"`

claim=`cat "$SCRIPTPATH/jenkins-claim.yaml" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{IMPORT_VOLUMES_COMMENT}}/$IMPORT_VOLUMES_COMMENT/g" `
echo "$claim" | kubectl create -n ${NS} -f -

if [[ $TARGET_STORAGE != "kontena"  ]]
then
    slaveclaim=`cat "$SCRIPTPATH/jenkins-claim-slave.yaml" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{IMPORT_VOLUMES_COMMENT}}/$IMPORT_VOLUMES_COMMENT/g" `
    echo "$slaveclaim" | kubectl create -n ${NS} -f -
fi

# Install jenkins component 
echo "$template" | helm install --name pure-jenkins-${NS} "$SCRIPTPATH/jenkins" --namespace ${NS} -f -

# Create Jenkins slave PVCs
bash "$SCRIPTPATH/jenkins-slave-claim.sh"