#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh



# Install Grafana Compoent using Helm chart
# No PVC is used
kubectl create -n ${NS} secret generic grafana-creds  --from-literal=admin.userKey=admin  --from-literal=admin.passwordKey=admin

template=`cat "$SCRIPTPATH/value.yaml"`
echo "$template" | helm install --name pure-grafana-${NS} stable/grafana --namespace ${NS} -f -