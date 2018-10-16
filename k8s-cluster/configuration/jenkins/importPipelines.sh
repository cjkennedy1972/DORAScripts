# java -jar jenkins-cli.jar -s http://10.21.236.87:8081 -auth admin:732d3ee373dad7a3912bcfa5def98e8c get-job build-kernel_Stage1 > build-kernel_Stage1.xml

#Enter your Jenkins Admin token (such as "110d236e680985f5710185c912d1cf9d91"), to be generated from User -> Configure -> API Token
JENKINS_API_TOKEN=$1
#Enter the URL of your Jenkins server installation, such as "http://10.21.236.87:8082"
JENKINS_SERVER_URL=$2

java -jar jenkins-cli.jar -s $JENKINS_SERVER_URL -auth admin:$JENKINS_API_TOKEN create-job build-kernel_Stage1 < build-kernel_Stage1.xml
java -jar jenkins-cli.jar -s $JENKINS_SERVER_URL -auth admin:$JENKINS_API_TOKEN create-job build-kernel_Stage2_Stage3 < build-kernel_Stage2_Stage3.xml
