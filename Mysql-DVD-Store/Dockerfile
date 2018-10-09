FROM mysql:5.7

MAINTAINER "Farida"
ENV KUBE_LATEST_VERSION="v1.10.5"

RUN apt update && apt install ca-certificates curl perl -y \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl

RUN chmod -R 777 /etc
RUN chmod -R 777 /var/run
RUN chmod -R 777 /usr/local/bin
RUN chmod -R 777 /usr/bin
RUN chmod -R 777 /run
