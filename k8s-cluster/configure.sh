#!/bin/bash

. environment.sh

bash ./configuration/nexus/config-docker-registry.sh

bash ./configuration/nexus/create-repositories.sh

bash ./configuration/gitlab/createProjects.sh

bash ./configuration/jenkins/importPipelines.sh ${NS}

bash ./configuration/nexus/create-and-push-docker-images.sh
