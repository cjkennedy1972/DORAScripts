#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh



# Install Grafana Compoent using Helm chart
# No PVC is used
kubectl create -n ${NS} secret generic grafana-creds  --from-literal=admin-user=admin  --from-literal=admin-password=admin

#template=`cat "$SCRIPTPATH/values.yaml"`
helm install --name pure-grafana-${NS} stable/grafana --namespace ${NS} -f "${SCRIPTPATH}"/values.yaml \
--set ingress.hosts[0]=${GRAFANA_HOSTNAME}
#echo "$template" | helm install --name pure-grafana-${NS} stable/grafana --namespace ${NS} -f -