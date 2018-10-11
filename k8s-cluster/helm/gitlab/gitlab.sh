#!/bin/bash
# customize if Jenkins shouldn't be deployed in the default namespace
NS="default" 

# Create persistent value claims for PostgreSQL, Redis, ETC and GitLab Data
kubectl create -f pvc.yaml -n ${NS}

# Install GitLab's Helm chart
helm install --name ps-gitlab -f values.yaml gitlab-ce --namespace ${NS} 
