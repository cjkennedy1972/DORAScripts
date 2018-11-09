#!/bin/bash

. environment.sh

kubectl create ns ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh
sleep 2
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh
sleep 2
bash wait-for.sh pod -lapp=pure-jenkins -n ${NS}

#Install only GitLab on FlashBlade
if [[ $TARGET_DEPLOYMENT == "fb" ]]
then
    bash ./helm/gitlab/gitlab.sh
    sleep 2
    bash wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
fi