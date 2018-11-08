#!/bin/bash

. environment.sh

kubectl create ns ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh ${NEXUS_IP} ${NEXUS_PORT} ${NS}
sleep 2
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh ${JENKINS_IP} ${JENKINS_PORT} ${NS}
sleep 2
bash wait-for.sh pod -lapp=pure-jenkins -n ${NS}

DOCKER_REGISTRY=${NEXUS_IP}:${DOCKER_REGISTRY_PORT}
kubectl create -n ${NS} secret docker-registry jenkins-pull --docker-server=$DOCKER_REGISTRY --docker-username=admin --docker-password=admin123 --docker-email=pure@pure.pure

#Install GitLab
bash ./helm/gitlab/gitlab.sh ${GITLAB_IP} ${GITLAB_PORT} ${NS}
sleep 2
bash wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
