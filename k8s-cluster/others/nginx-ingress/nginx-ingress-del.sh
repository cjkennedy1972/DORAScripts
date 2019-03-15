#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

kubectl delete -f "$SCRIPTPATH/nginx-ingress-controller.yaml"
kubectl delete -f "$SCRIPTPATH/nginx-ingress-service.yaml"
