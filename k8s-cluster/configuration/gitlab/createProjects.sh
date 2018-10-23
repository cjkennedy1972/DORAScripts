#Enter your GitLab API token (such as "4Lq4rSxSZcVd3CWuCF85"), to be generated from User -> Settings -> Access Tokens (with the 'api' scope)
#GITLAB_API_TOKEN=$1
#Enter the URL of your GitLab installation, such as "http://10.21.236.87:8083"
#GITLAB_SERVER_URL=$2

. environment.sh

# Enable "Allow requests to the local network from hooks and services" (Admin Area -> Settings)
curl --request PUT -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "http://$GITLAB_IP:$GITLAB_PORT/api/v4/application/settings?allow_local_requests_from_hooks_and_services=true"

# Setting up the Ubuntu Xenial repository - to be deleted
curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=ubuntu-xenial&issues_enabled=false&import_url=git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git"

# Create the Jenkins web hook for the Build-Kernel-Stage1 pipeline
curl -H "PRIVATE-TOKEN: $GITLAB_TOKEN" -H 'Content-Type: application/json' -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects/1/hooks" -d '{
#  "url": "http://'$JENKINS_IP':'$JENKINS_PORT'/project/Build-Kernel-Stage1",
#  "push_events": true,
#  "enable_ssl_verification": false,
#  "token": "'$SECRET_TOKEN'"
#  }'