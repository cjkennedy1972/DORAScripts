#!/bin/bash
#customize the NS variable below to deploy to a different Kubernetes namespace
NS="default"
# Install nexus component 
kubectl create -f nexus-claim.yaml -n ${NS} 
kubectl create -f service.yaml -n ${NS}
kubectl create -f deployment.yaml -n ${NS}  
