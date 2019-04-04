#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ansible-playbook -i "$SCRIPTPATH"/inventory.cfg "$SCRIPTPATH/add-docker-insecure-registry.yml" --extra-vars "docker_insecure_registry=$NEXUS_IP:$DOCKER_REGISTRY_PORT" 

# Wait to make sure all of our app containers have properly restarted
bash "$SCRIPTPATH"/../../wait-for.sh pod -lapp=pure-gitlab-${NS}-redis -n ${NS}
bash "$SCRIPTPATH"/../../wait-for.sh pod -lapp=pure-gitlab-${NS}-postgresql -n ${NS}
bash "$SCRIPTPATH"/../../wait-for.sh pod -lapp=pure-gitlab-${NS}-gitlab-ce -n ${NS}
bash "$SCRIPTPATH"/../../wait-for.sh pod -lapp=pure-jenkins-${NS} -n ${NS}
bash "$SCRIPTPATH"/../../wait-for.sh pod -lapp=nexus -n ${NS}