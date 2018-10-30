#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Enable "Allow requests to the local network from hooks and services" (Admin Area -> Settings)
curl --request PUT -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "http://$GITLAB_IP:$GITLAB_PORT/api/v4/application/settings?allow_local_requests_from_hooks_and_services=true"

# Se up the Ubuntu Xenial repository - to be deleted
#curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=ubuntu-xenial&issues_enabled=false&import_url=git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git"

# Clone the wordpress-develop repository from GitHub to the GitLab internal server
curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=wordpress-develop&issues_enabled=false&import_url=git://github.com/WordPress/wordpress-develop.git"

# Create the Jenkins web hook for the Build-WordPress-Job pipeline
curl -H "PRIVATE-TOKEN: $GITLAB_TOKEN" -H 'Content-Type: application/json' -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects/1/hooks" -d '{
#  "url": "http://'$JENKINS_IP':'$JENKINS_PORT'/project/Build-WordPress-Job",
#  "push_events": true,
#  "enable_ssl_verification": false,
#  "token": "'$SECRET_TOKEN'"
#  }'