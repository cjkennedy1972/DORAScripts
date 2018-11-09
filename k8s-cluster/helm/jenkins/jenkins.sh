#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# reads the yml template from a file and substitutes: 
# {{JENKINS_IP_ADDRESS}} with the value of the JENKINS_IP variable
# {{JENKINS_PORT}} with the value of the JENKINS_PORT variable
template=`cat "$SCRIPTPATH/jenkins.yaml" | sed "s/{{JENKINS_IP_ADDRESS}}/$JENKINS_IP/g" | sed "s/{{JENKINS_PORT}}/$JENKINS_PORT/g"`

# Install jenkins component 
kubectl create -f "$SCRIPTPATH/jenkins-claim.yaml" -n ${NS}
echo "$template" | helm install --name pure-jenkins "$SCRIPTPATH/jenkins" --namespace ${NS} -f -
#helm install --name pure-jenkins -f "$SCRIPTPATH/jenkins.yaml" stable/jenkins --namespace ${NS} 