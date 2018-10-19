#!/bin/bash
# java -jar jenkins-cli.jar -s http://10.21.236.87:8081 -auth admin:732d3ee373dad7a3912bcfa5def98e8c get-job build-kernel_Stage1 > build-kernel_Stage1.xml
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
#Enter your Jenkins Admin token (such as "110d236e680985f5710185c912d1cf9d91"), to be generated from User -> Configure -> API Token
JENKINS_API_TOKEN=$1
#Enter the URL of your Jenkins server installation, such as "http://10.21.236.87:8082"
JENKINS_SERVER_URL=$2

NEXUS_IP=$3
GITLAB_IP=$4

cp "$SCRIPTPATH/Build-Kernel-Stage-1.xml" "$SCRIPTPATH/temp.xml"
sed -i '' "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml"
sed -i '' "s/{{GITLAB_IP_ADDRESS}}/${GITLAB_IP}/g" "$SCRIPTPATH/temp.xml"
#sed "s/{{NEXUS_IP_ADDRESS}}/${NEXUS_IP}/g" "$SCRIPTPATH/temp.xml" > "$SCRIPTPATH/temp2.xml"
#sed "s/{{GITLAB_IP_ADDRESS}}/$GITLAB_IP/g" "$SCRIPTPATH/temp2.xml" > "$SCRIPTPATH/temp.xml"

java -jar "$SCRIPTPATH/jenkins-cli.jar" -s $JENKINS_SERVER_URL -auth admin:$JENKINS_API_TOKEN create-job Build-Kernel_Stage1 < "$SCRIPTPATH/temp.xml"
#java -jar jenkins-cli.jar -s $JENKINS_SERVER_URL -auth admin:$JENKINS_API_TOKEN create-job build-kernel_Stage2_Stage3 < build-kernel_Stage2_Stage3.xml

rm "$SCRIPTPATH/temp.xml"