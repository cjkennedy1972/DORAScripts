#!/bin/bash
# Install jenkins component 
Kubectl create –f  jenkins-claim.yaml -n ${NS}
helm install --name ps-jenkins -f values.yaml jenkins --namespace ${NS} 