# How to configure Gitlab and Jenkins job
## Create the base image to build the kernel
1. docker build -t "nexus-server-ip":5000/tensorflow .
2. docker push "nexus-server-ip":5000/tensorflow  

## Gitlab Configuration
1. Import the tensor Repo in Gitlab: https://github.com/tensorflow/tensorflow 
2. Create the master branch
3. Copy the Jenkinsfile

## Jenkins Configuration
1. Create a new pipeline job in Jenkins
2. Configure pipeline script for scm
   ![Alt text](./jenkins-gitlab-settings.png?raw=true "Title")

  
