#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh



# Install Prometheus Compoent using Helm chart
# No PVC is used
template=`cat "$SCRIPTPATH/value.yaml"`
echo "$template" | helm install --name pure-prometheus-${NS} stable/prometheus --namespace ${NS} -f -