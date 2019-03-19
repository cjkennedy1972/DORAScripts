#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

kubectl apply -f "$SCRIPTPATH/nginx-ingress-controller.yaml"
kubectl apply -f "$SCRIPTPATH/nginx-ingress-service.yaml"
