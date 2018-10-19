#!/bin/bash
#Set the default namespace to which we'll deploy our Kubernetes resources
NS="pure"
JENKINS_IP="1.1.1.1"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -z $1 ]
then
    JENKINS_IP=$1
else
    echo "Aborting, the JENKINS_IP parameter is missing"
    exit 0
fi
#echo $JENKINS_IP

if [ ! -z $2 ]
then
    NS=$2
fi

# read the yml template from a file and substitute the string 
# {{JENKINS_IP_ADDRESS}} with the value of the JENKINS_IP variable
template=`cat "$SCRIPTPATH/jenkins.yaml" | sed "s/{{JENKINS_IP_ADDRESS}}/$JENKINS_IP/g"`
# Install jenkins component 
kubectl create -f "$SCRIPTPATH/jenkins-claim.yaml" -n ${NS}
echo "$template" | helm install --name pure-jenkins "$SCRIPTPATH/jenkins" --namespace ${NS} -f -
#helm install --name pure-jenkins -f "$SCRIPTPATH/jenkins.yaml" stable/jenkins --namespace ${NS} 