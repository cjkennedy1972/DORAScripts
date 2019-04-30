#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Install Prometheus Compoent using Helm chart
# No PVC is used
helm install --name pure-prometheus-${NS} stable/prometheus --namespace ${MONITORING_NS} -f "$SCRIPTPATH/values.yaml"