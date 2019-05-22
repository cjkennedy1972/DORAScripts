#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Install Prometheus using Helm chart
helm install --name pure-prometheus-${NS} stable/prometheus --namespace ${MONITORING_NS} -f "$SCRIPTPATH"/values.yaml