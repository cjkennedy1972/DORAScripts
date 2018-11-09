#!/bin/bash

bash ./configuration/nexus/config-docker-registry.sh

bash ./configuration/nexus/create-repositories.sh

bash ./configuration/gitlab/createProjects.sh

bash ./configuration/jenkins/importPipelines.sh 

bash ./configuration/nexus/create-and-push-docker-images.sh

