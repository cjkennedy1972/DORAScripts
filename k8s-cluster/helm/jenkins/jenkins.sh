#!/bin/bash
# customize if Jenkins shouldn't be deployed in the default namespace
NS="default" 
# Install jenkins component 
kubectl create -f jenkins-claim.yaml -n ${NS}
helm install --name ps-jenkins -f values.yaml jenkins --namespace ${NS} 