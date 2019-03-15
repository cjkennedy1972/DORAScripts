#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

# Enable "Allow requests to the local network from hooks and services" (Admin Area -> Settings)
curl --request PUT -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "http://$GITLAB_IP:$GITLAB_PORT/api/v4/application/settings?allow_local_requests_from_hooks_and_services=true"

# Clone the wordpress-develop repository from GitHub to the GitLab internal server
curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=wordpress-develop&issues_enabled=false&import_url=git://github.com/WordPress/wordpress-develop.git"

# Create the Jenkins web hook for the Build-WordPress-Job pipeline
echo -e "\nSetting up web hook in wordpress-develop repository"
curl -H "PRIVATE-TOKEN: $GITLAB_TOKEN" -H 'Content-Type: application/json' -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v4/projects/root%2Fwordpress-develop/hooks" -d '{
  "url": "http://'$JENKINS_IP':'$JENKINS_PORT'/project/WordPress-CI-Job",
  "push_events": true,
  "enable_ssl_verification": false,
  "token": "'$SECRET_TOKEN'"
  }'
echo -e "\nDone setting up web hook in wordpress-develop repository"

# Setting up new project for storing WordPress CD files
curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=wordpress-cd&issues_enabled=false&default_branch=4.9"

## Git init and check-in files
cd /tmp
rm -rf /tmp/wordpress-cd
mkdir wordpress-cd
cd wordpress-cd
git clone "http://oauth2:$GITLAB_TOKEN@$GITLAB_IP:$GITLAB_PORT/root/wordpress-cd.git"
cp -rf "$SCRIPTPATH"/wordpress-cd/* wordpress-cd/.
cp -rf "$SCRIPTPATH"/wordpress-cd/sshkey wordpress-cd/.
cp "$SCRIPTPATH"/../../../vm-cluster/configuration/wordpress/files/blog.php wordpress-cd/stage-3/.
cd wordpress-cd
git add .
git add sshkey -f
git commit -m "Checking in files"
git push
