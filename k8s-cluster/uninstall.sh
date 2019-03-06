#!/bin/bash

UNINSTALL_ALL="no"
if [ ! -z $2 ]
then
    UNINSTALL_ALL=$2
fi

. environment.sh

helm delete pure-jenkins-${NS} --purge
helm delete pure-gitlab-${NS} --purge
kubectl -n ${NS} delete deployment,svc,pod,secret --all

#only delete the persistent volumes if we specify "all" as a parameter
if [[ $UNINSTALL_ALL == "all" ]]
then
    echo "Deleting persistent storage volumes from namespace" ${NS}
    kubectl -n ${NS} delete pvc --all
    kubectl delete ns ${NS}
    echo "Deleting Prometheus/ Grafana helm charts" ${NS}
    helm delete pure-prometheus-${NS} --purge
    helm delete pure-grafana-${NS} --purge
else
    echo "Leaving persistent storage volumes alive in namespace" ${NS}
fi

#Uninstall Sonatype Nexus
#template=`cat "./others/nexus/service.yaml" | sed "s/{{NEXUS_IP_ADDRESS}}/1.1.1.1/g"`
#echo "$template" | kubectl delete -n ${NS} -f -
#kubectl -n ${NS} delete -f ./others/nexus/deployment.yaml 
#kubectl -n ${NS} delete -f ./others/nexus/nexus-claim.yaml

#Uninstall Jenkins
#helm delete pure-jenkins --purge
#kubectl -n ${NS} delete -f ./helm/jenkins/jenkins-claim.yaml 

#Uninstall GitLab
#helm delete pure-gitlab --purge
#kubectl -n ${NS} delete -f ./helm/gitlab/pvc.yaml 

#delete Docker registry secret
#kubectl -n ${NS} delete secret jenkins-pull

#kubectl delete ns ${NS}

#kubectl -n pure --force --grace-period=0 delete pod <POD_NAME>