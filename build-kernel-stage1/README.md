# How to configure Gitlab and Jenkins job
## Create the base image to build the kernel
1. docker build -t "nexus-server-ip":5000/build-kernel .
2. docker push "nexus-server-ip":5000/build-kernel  

## Gitlab Configuration
1. Import the Ubuntu-kernel Repo in Gitlab:  git://kernel.ubuntu.com
2. Create the develop branch(as we can not work on master branch)
3. Copy the Jenkinsfile

## Jenkins Configuration
1. Create a new parametrized pipeline job in Jenkins
2. Enable "This project is parameterized" option
3. Add the folowing parameters
    ![](./jenkins-parametrized-settings.png?raw=true "Title")
4. Configure pipeline script for scm
   ![Alt text](./jenkins-gitlab-settings.png?raw=true "Title")

  
