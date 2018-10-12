#Enter your GitLab API token (such as "4Lq4rSxSZcVd3CWuCF85"), to be generated from User -> Settings -> Access Tokens (with the 'api' scope)
GITLAB_API_TOKEN=$1
#Enter the URL of your GitLab installation, such as "http://10.21.236.87:8083"
GITLAB_SERVER_URL=$2
curl --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" -X POST "$GITLAB_SERVER_URL/api/v3/projects?name=ubuntu-xenial&issues_enabled=false&import_url=git://kernel.ubuntu.com/ubuntu/ubuntu-xenial.git"