#!/bin/bash
# Install nexus component 
kubectl create -f nexus-claim.yaml -n ${NS} 
kubectl create -f deployment.yaml -n ${NS} 
kubectl create -f service.yaml -n ${NS} 