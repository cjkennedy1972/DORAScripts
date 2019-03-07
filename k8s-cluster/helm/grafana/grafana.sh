#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh



# Install Grafana Compoent using Helm chart
# No PVC is used
kubectl create -n ${MONITORING_NS} secret generic grafana-creds  --from-literal=admin.userKey=admin  --from-literal=admin.passwordKey=admin

template=`cat "$SCRIPTPATH/values.yaml"`
echo "$template" | helm install --name pure-grafana stable/grafana --namespace ${MONITORING_NS} -f -