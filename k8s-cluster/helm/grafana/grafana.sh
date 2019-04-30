#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh



# Install Grafana Component using Helm chart
# No PVC is used
kubectl create -n ${NS} secret generic grafana-creds  --from-literal=admin-user=admin  --from-literal=admin-password=admin

helm install --name pure-grafana-${NS} stable/grafana --namespace ${NS} -f "${SCRIPTPATH}"/values.yaml \
--set ingress.hosts[0]=${GRAFANA_HOSTNAME}

# Create Grafana Service
kubectl create -n ${MONITORING_NS} -f "$SCRIPTPATH/metallb-grafana-svc.yaml"