#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Install Nexus Repository Manager resources 
config=`cat "$SCRIPTPATH/layer2-config.yaml" | sed "s/{{METAL_LB_IP_CIDR}}/$METAL_LB_IP_CIDR/g"`
template=`cat "$SCRIPTPATH/metallb.yaml"`

echo "$config" | kubectl create -f -
echo "$template" | kubectl create -f -

