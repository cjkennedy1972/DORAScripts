#!/bin/bash
# Install jira component

# Create PVC
kubectl create -f claim.yaml -n ${NS} 

# Create Deployment
kubectl create -f deployment.yaml -n ${NS} 

# Create Service
kubectl create -f service.yaml -n ${NS}