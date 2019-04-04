#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Install Prometheus using Helm chart
template=`cat "$SCRIPTPATH/values.yaml"`
helm install --name pure-prometheus-${NS} stable/prometheus --namespace ${NS} -f "$SCRIPTPATH"/values.yaml
#echo "$template" | helm install --name pure-prometheus-${NS} stable/prometheus --namespace ${NS} -f -