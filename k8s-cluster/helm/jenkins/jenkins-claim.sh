#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

for (( i=1; i <= 10; ++i ))
do
    echo "Creating claim $i" 
    claim=`cat "$SCRIPTPATH/jenkins-claim-flashblade.yaml" | sed "s/{{counter}}/$i/g"`
    #echo "$claim $NS"
    echo "$claim" | kubectl create -n ${NS} -f -
done