# How to configure Gitlab and Jenkins job
## Create the base image to build the mysql
1. docker build .
2. docker tag mysql "nexus-server-ip":5000/mysql-custom .
2. docker push "nexus-server-ip":5000/mysql-custom 
3. docker build 5.7 .
4. docker tag 5.7  "nexus-server-ip":5000/mysql:v1 .
4. docker push "nexus-server-ip":5000/mysql:v1 

## Gitlab Configuration
1. Import the DORAScript Repo in Gitlab:  https://github.com/PureStorage-OpenConnect/DORAScripts.git and navigate to Mysql-DVD-Store folder for DVD-Store required files
2. To create Config file under k8s-file folder we need to copy config from ~/.kube/config from terminal

## Jenkins Configuration
1. Create a new pipeline job in Jenkins
2. Enable "Build when a change is pushed to GitLab. GitLab webhook URL: http://<gitlab_ip:port>/project/build-dvd-store" option
3. Add the Git repository URL and Credentials in pipeline section
4. Add Jenkinsfile path in script path

