# How to configure Gitlab and Jenkins job
## Create the base image to build the wordpress
1. docker build -t "nexus-server-ip":5000/build-wordpress .
2. docker push "nexus-server-ip":5000/build-wordpress  

## Gitlab Configuration
1. Import the word-press Repo in Gitlab:  https://github.com/WordPress/wordpress-develop.git
2. Create the develop branch
3. Copy the Jenkinsfile

## Jenkins Configuration
1. Create a new pipeline job in Jenkins
2. Configure pipeline script for scm
   ![](./jenkins-gitlab-settings.png?raw=true "Title")

## Execute multiple jobs in jenkins
1. copy the create-pr.sh
2. run ./create-pr.sh 1 40, it will start the 40 jobs on Jenkins server
  
