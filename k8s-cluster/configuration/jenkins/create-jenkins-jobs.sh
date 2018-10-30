#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

for (( i=1; i <= $1; ++i ))
do
java -jar "$SCRIPTPATH/jenkins-cli.jar" -noKeyAuth -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN build Build-WordPress-Job

done
exit 0