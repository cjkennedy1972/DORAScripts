#!/bin/bash
#Set the default namespace to which we'll deploy our Kubernetes resources
NS="pure"
NEXUS_IP="1.1.1.1"
NEXUS_PORT="80"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -z $1 ]
then
    NEXUS_IP=$1
else
    echo "Aborting, the NEXUS_IP parameter is missing"
    exit 0
fi
#echo $NEXUS_IP

if [ ! -z $2 ]
then
    NEXUS_PORT=$2
fi

if [ ! -z $3 ]
then
    NS=$3
fi
#echo $NS

# read the yml template from a file and substitute the string 
# {{NEXUS_IP_ADDRESS}} with the value of the NEXUS_IP variable
template=`cat "$SCRIPTPATH/service.yaml" | sed "s/{{NEXUS_IP_ADDRESS}}/$NEXUS_IP/g" | sed "s/{{DOCKER_REGISTRY_PORT}}/$DOCKER_REGISTRY_PORT/g" | sed  "s/{{NEXUS_PORT}}/$NEXUS_PORT/g"`

#echo $SCRIPTPATH
# Install Nexus Repository Manager resources 
kubectl create -f "$SCRIPTPATH/nexus-claim.yaml" -n ${NS}
echo "$template" | kubectl create -n ${NS} -f -
kubectl create -f "$SCRIPTPATH/deployment.yaml" -n ${NS}
