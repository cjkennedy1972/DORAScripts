#!/bin/bash

. environment.sh

kubectl create ns ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh ${NEXUS_IP} ${NEXUS_PORT} ${NS}
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh ${JENKINS_IP} ${JENKINS_PORT} ${NS}
bash wait-for.sh pod -lapp=pure-jenkins -n ${NS}

#Install GitLab
bash ./helm/gitlab/gitlab.sh ${GITLAB_IP} ${GITLAB_PORT} ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
