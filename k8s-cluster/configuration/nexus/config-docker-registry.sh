#!/bin/bash

. environment.sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ansible-playbook -i ../kube-ansible/inventory "$SCRIPTPATH/add-docker-insecure-registry.yml" --check --extra-vars "docker_insecure_registry=$NEXUS_IP:$DOCKER_REGISTRY_PORT" 