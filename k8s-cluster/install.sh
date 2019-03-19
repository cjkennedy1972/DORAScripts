#!/bin/bash

. environment.sh

kubectl create ns ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh ${NS}
sleep 2
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh ${NS}
sleep 2
bash wait-for.sh pod -lapp=pure-jenkins-${NS} -n ${NS}

#Install only GitLab on FlashBlade
if [[ $TARGET_DEPLOYMENT == "onprem" ]]
then
    bash ./helm/gitlab/gitlab.sh ${NS}
    sleep 2
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-redis -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-postgresql -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-${NS}-gitlab-ce -n ${NS}
fi

if [[ $METAL_LB_NGINX_INGRESS == "true" ]]
then
    #Install metal-LB
    kubectl create ns metallb-system
    bash ./others/metal-lb/metal-lb.sh
    sleep 2
    bash wait-for.sh pod -lapp=metallb -n metallb-system

    #Install Nginx Ingress
    kubectl create ns ingress-nginx
    bash ./others/nginx-ingress/nginx-ingress.sh
    sleep 2
    bash wait-for.sh pod -lapp=ingress-nginx -n ingress-nginx
fi

if [[ $ENABLE_MONITORING == "true" ]]
then
    bash ./helm/prometheus/prometheus.sh
    bash ./helm/grafana/grafana.sh
    sleep 2
    bash wait-for.sh pod -lapp=prometheus -n ${MONITORING_NS}
    bash wait-for.sh pod -lapp=grafana -n ${MONITORING_NS}
fi
