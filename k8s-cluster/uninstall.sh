#!/bin/bash
#Set the default namespace to which we'll deploy our Kubernetes resources
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

#Uninstall Sonatype Nexus
template=`cat "./others/nexus/service.yaml" | sed "s/{{NEXUS_IP_ADDRESS}}/1.1.1.1/g"`
echo "$template" | kubectl delete -n ${NS} -f -
kubectl -n ${NS} delete -f ./others/nexus/deployment.yaml 
kubectl -n ${NS} delete -f ./others/nexus/nexus-claim.yaml

#Uninstall Jenkins
helm delete pure-jenkins --purge
kubectl -n ${NS} delete -f ./helm/jenkins/jenkins-claim.yaml 

#Uninstall GitLab
helm delete pure-gitlab --purge
kubectl -n ${NS} delete -f ./helm/gitlab/pvc.yaml 

kubectl delete ns ${NS}