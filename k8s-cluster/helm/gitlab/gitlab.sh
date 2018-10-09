#!/bin/bash
# Install gitlab component

# Create PVC for Postgres 
kubectl create -f pg.yaml -n ${NS}

# Create PVC for Redis
kubectl create -f redis.yaml -n ${NS}
kubectl create -f data.yaml -n ${NS}
kubectl create -f etc.yaml -n ${NS}

# Install helm chart
helm install --name ps-gitlab -f values.yaml gitlab-ce --namespace ${NS} 
