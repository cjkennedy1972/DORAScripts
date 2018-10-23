#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

kubectl create -f "$SCRIPTPATH/rbac-config.yaml"
helm init --service-account tiller --upgrade
helm repo update
