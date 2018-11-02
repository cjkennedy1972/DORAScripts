#!/bin/sh

. environment.sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

RANDOM_NUMBER=$RANDOM

curl -X POST -u admin:admin123 --header 'Content-Type: application/json' \
    http://$NEXUS_IP:$NEXUS_PORT/service/rest/v1/script \
    -d '{"name":"raw-pure'$RANDOM_NUMBER'","type":"groovy","content":"repository.createRawHosted('\''builds-store'\'');"}'
curl -X POST -u admin:admin123 --header "Content-Type: text/plain" 'http://'$NEXUS_IP':'$NEXUS_PORT'/service/rest/v1/script/raw-pure'$RANDOM_NUMBER'/run'


curl -X POST -u admin:admin123 --header 'Content-Type: application/json' \
    http://$NEXUS_IP:$NEXUS_PORT/service/rest/v1/script \
    -d '{"name":"docker-pure'$RANDOM_NUMBER'","type":"groovy","content":"repository.createDockerHosted('\''docker'\'', 5000, 5001, '\''default'\'', true, true);"}'
curl -X POST -u admin:admin123 --header "Content-Type: text/plain" 'http://'$NEXUS_IP':'$NEXUS_PORT'/service/rest/v1/script/docker-pure'$RANDOM_NUMBER'/run'