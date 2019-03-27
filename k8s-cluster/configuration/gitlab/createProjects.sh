#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

GITLAB_HOST=$GITLAB_IP:$GITLAB_PORT
GITLAB_HOST=gitlab-dev.puretec.purestorage.com
GITLAB_URL="$GITLAB_HTTP_PREFIX://$GITLAB_HOST"

# Enable "Allow requests to the local network from hooks and services" (Admin Area -> Settings)
curl --insecure --request PUT -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "$GITLAB_URL/api/v4/application/settings?allow_local_requests_from_hooks_and_services=true"

# Clone the wordpress-develop repository from GitHub to the GitLab internal server
curl --insecure --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "$GITLAB_URL/api/v4/projects?name=wordpress-develop&issues_enabled=false&default_branch=4.9&import_url=git://github.com/WordPress/wordpress-develop.git"

# Create the Jenkins web hook for the WordPress-CI-Job pipeline
echo -e "\nSetting up web hook in wordpress-develop repository"
curl --insecure -H "PRIVATE-TOKEN: $GITLAB_TOKEN" -H 'Content-Type: application/json' -X POST "$GITLAB_URL/api/v4/projects/root%2Fwordpress-develop/hooks" -d '{
  "url": "http://'$JENKINS_IP':'$JENKINS_PORT'/project/WordPress-CI-Job",
  "push_events": true,
  "enable_ssl_verification": false,
  "token": "'$SECRET_TOKEN'"
  }'
echo -e "\nDone setting up web hook in wordpress-develop repository"

# Setting up new project for storing WordPress CD files
curl --insecure --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "$GITLAB_URL/api/v4/projects?name=wordpress-cd&issues_enabled=false"
sleep 5
## Git init and check-in files
cd /tmp
rm -rf /tmp/wordpress-cd
mkdir wordpress-cd
echo -e "\ncreated wordpress-cd folder"
cd wordpress-cd
echo -e "\ncloning"
git config --global http.sslVerify false
git clone "$HTTP_PREFIX://oauth2:$GITLAB_TOKEN@$GITLAB_HOST/root/wordpress-cd.git"
echo -e "\nafter cloning"
cp -Rf "$SCRIPTPATH"/wordpress-cd/* wordpress-cd/.
cp -Rf "$SCRIPTPATH"/wordpress-cd/sshkey wordpress-cd/.
#cp "$SCRIPTPATH"/../../../vm-cluster/configuration/wordpress/files/blog.php wordpress-cd/stage-3/.
cd wordpress-cd
git config --global http.sslVerify false
git add .
git add sshkey -f
git commit -m "Checking in wordpress-cd initial files"
#git config --global http.sslVerify false
git push

# Setting up new project for storing HA-Proxy files
curl --insecure --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "$GITLAB_URL/api/v4/projects?name=ha-proxy&issues_enabled=false&default_branch=master"

## Git init and check-in files
cd /tmp
rm -rf /tmp/ha-proxy
mkdir ha-proxy
echo -e "\ncreated ha-proxy folder"
cd ha-proxy
git config --global http.sslVerify false
git clone "$HTTP_PREFIX://oauth2:$GITLAB_TOKEN@$GITLAB_HOST/root/ha-proxy.git"
cp -rf "$SCRIPTPATH"/ha-proxy/haproxy.cfg ha-proxy/
cd ha-proxy
git add haproxy.cfg -f
git commit -m "Checking in files"
git config --global http.sslVerify false
git push
