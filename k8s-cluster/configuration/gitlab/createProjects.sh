#Enter your GitLab API token (such as "4Lq4rSxSZcVd3CWuCF85"), to be generated from User -> Settings -> Access Tokens (with the 'api' scope)
GITLAB_API_TOKEN=$1
#Enter the URL of your GitLab installation, such as "http://10.21.236.87:8083"
GITLAB_SERVER_URL=$2

. environment.sh

curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects?name=ubuntu-xenial&issues_enabled=false&import_url=git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git"

#create the Jenkins web hooks
curl -H "PRIVATE-TOKEN: $GITLAB_TOKEN" -H 'Content-Type: application/json' -X POST "http://$GITLAB_IP:$GITLAB_PORT/api/v3/projects/1/hooks" -d '{
  "url": "http://'$JENKINS_IP':'$JENKINS_PORT'/project/Build-Kernel_Stage1",
  "push_events": true,
  "enable_ssl_verification": false,
  "token": "'$SECRET_TOKEN'"
  }'