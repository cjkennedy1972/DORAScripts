#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ansible-playbook -i "$SCRIPTPATH"/inventory.cfg "$SCRIPTPATH/add-docker-insecure-registry.yml" --check --extra-vars "docker_insecure_registry=$NEXUS_IP:$DOCKER_REGISTRY_PORT" 

# Wait to make sure all of our app containers have properly restarted
bash ../../wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
bash ../../wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
bash ../../wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
bash ../../wait-for.sh pod -lapp=pure-jenkins -n ${NS}
bash ../../wait-for.sh pod -lapp=nexus -n ${NS}