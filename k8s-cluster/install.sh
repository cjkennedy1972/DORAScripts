#!/bin/bash
#Set Kubernetes namespace
NS="pure"
if [ ! -z $1 ]
then
    NS=$1
fi

#Set environment variables
NEXUS_IP="10.21.236.87"
JENKINS_IP="10.21.236.88"
GITLAB_IP="10.21.236.89"

kubectl create ns ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh ${NEXUS_IP} ${NS}
#bash wait-for.sh service -n ${NS} nexus-service 
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh ${JENKINS_IP} ${NS}
#bash wait-for.sh service -n ${NS} pure-jenkins 
bash wait-for.sh pod -lapp=pure-jenkins -n ${NS}

#Install GitLab
bash ./helm/gitlab/gitlab.sh ${GITLAB_IP} ${NS}
#bash wait-for.sh service -n ${NS} pure-gitlab-gitlab-ce 
bash wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
bash wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
