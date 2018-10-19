#!/bin/bash
. environment.sh

helm delete pure-jenkins --purge
helm delete pure-gitlab --purge
kubectl -n ${NS} delete deployment,svc,pod,secret,pvc --all
kubectl delete ns ${NS}

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