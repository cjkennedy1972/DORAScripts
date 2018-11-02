#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

ansible-playbook -i "$SCRIPTPATH"/inventory.cfg "$SCRIPTPATH/add-docker-insecure-registry.yml" --check --extra-vars "docker_insecure_registry=$NEXUS_IP:$DOCKER_REGISTRY_PORT" 