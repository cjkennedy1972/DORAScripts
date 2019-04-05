#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

for (( i=1; i <= 100; ++i ))
do
    echo "Deleting claim $i" 
    claim=`cat "$SCRIPTPATH/jenkins-slave-pvc.yaml" | sed "s/{{counter}}/$i/g" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g"`
    #echo "$claim $NS"
    echo "$claim" | kubectl delete -n ${NS} -f -
done