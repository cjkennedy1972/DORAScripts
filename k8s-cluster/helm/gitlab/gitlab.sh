#!/bin/bash
#Set the default namespace to which we'll deploy our Kubernetes resources
NS="pure"
GITLAB_IP="1.1.1.1"
GITLAB_PORT="8080"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

if [ ! -z $1 ]
then
    GITLAB_IP=$1
else
    echo "Aborting, the GITLAB_IP parameter is missing"
    exit 0
fi
#echo $JENKINS_IP

if [ ! -z $2 ]
then
    GITLAB_PORT=$2
fi

if [ ! -z $3 ]
then
    NS=$3
fi

# read the yml template from a file and substitute the string 
# {{GITLAB_IP_ADDRESS}} with the value of the NEXUS_IP variable
template=`cat "$SCRIPTPATH/gitlab.yaml" | sed "s/{{GITLAB_IP_ADDRESS}}/$GITLAB_IP/g" | sed "s/{{GITLAB_PORT}}/$GITLAB_PORT/g"`
# Install GitLab component 
# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
kubectl create -f "$SCRIPTPATH/pvc.yaml" -n ${NS}
# Install GitLab's Helm chart
echo "$template" | helm install --name pure-gitlab "$SCRIPTPATH/gitlab-ce" --namespace ${NS} -f -

# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
#kubectl create -f pvc.yaml -n ${NS}

# Install GitLab's Helm chart
#helm install --name ps-gitlab -f values.yaml gitlab-ce --namespace ${NS} 
