# How to configure Gitlab and Jenkins job
## Gitlab Configuration
1. Import the Stage2 and Stage3 Repo in Gitlab: copy the folders from continous-deployment-stage2&3 directory
2. Create the develop branch(as we can not work on master branch)
3. Copy the Jenkinsfile

## Jenkins Configuration
1. Create a new paramertized pipeline job in Jenkins
2. Select the option "This project is parameterized"
3. Add "String Parameter"
    ![](./jenkins-parametrized-settings.png?raw=true "Title")
4. Configure pipeline script for scm
   ![](./jenkins-gitlab-settings.png?raw=true "Title")
