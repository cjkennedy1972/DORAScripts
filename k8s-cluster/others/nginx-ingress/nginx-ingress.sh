#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

kubectl create --dry-run -f "$SCRIPTPATH/nginx-ingress-controller.yaml"
kubectl create --dry-run -f "$SCRIPTPATH/nginx-ingress-service.yaml"
