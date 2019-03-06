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
bash wait-for.sh pod -lapp=pure-jenkins-${NS} -n ${NS}

#Install only GitLab on FlashBlade
if [[ $TARGET_DEPLOYMENT == "onprem" ]]
then
    bash ./helm/gitlab/gitlab.sh
    sleep 2
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-redis -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-postgresql -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-gitlab-ce -n ${NS}
fi

if [[ $METAL_LB_NGINX_INGRESS == "true" ]]
then
    #Install metal-LB
    kubectl create ns ${METAL_LB_NS}
    bash ./others/metal-lb/metal-lb.sh
    sleep 2
    bash wait-for.sh pod -lapp=metallb -n ${METAL_LB_NS}

    #Install Nginx Ingress
    kubectl create ns ${NGINX_INGRESS_NS}
    bash ./others/nginx-ingress/nginx-ingress.sh
    sleep 2
    bash wait-for.sh pod -lapp=ingress-nginx -n ${NGINX_INGRESS_NS}
fi