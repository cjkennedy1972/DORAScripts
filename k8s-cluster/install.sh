#!/bin/bash

. environment.sh

kubectl create ns ${NS}

#Install metal-LB
kubectl create ns metallb-system
bash ./others/metal-lb/metal-lb.sh
sleep 2
bash wait-for.sh pod -lapp=metallb -n metallb-system

#Install Nginx Ingress
kubectl create ns ingress-nginx
bash ./others/nginx-ingress/nginx-ingress.sh
sleep 2
bash wait-for.sh pod -lapp.kubernetes.io/name=ingress-nginx -n ingress-nginx

bash ./configuration/nginx-ingress/nginx-ingress.sh ${NS}

#Install Sonatype Nexus
bash ./others/nexus/nexus.sh ${NS}
sleep 2
bash wait-for.sh pod -lapp=nexus -n ${NS}

#Install Jenkins
bash ./helm/jenkins/jenkins.sh ${NS}
sleep 2
bash wait-for.sh pod -lapp=pure-jenkins -n ${NS}

#Install only GitLab on FlashBlade
if [[ $TARGET_DEPLOYMENT == "onprem" ]]
then
    bash ./helm/gitlab/gitlab.sh ${NS}
    sleep 2
    bash wait-for.sh pod -lapp=pure-gitlab-redis -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-postgresql -n ${NS}
    bash wait-for.sh pod -lapp=pure-gitlab-gitlab-ce -n ${NS}
fi
