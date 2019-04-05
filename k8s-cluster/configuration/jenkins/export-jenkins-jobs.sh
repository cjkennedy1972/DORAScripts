#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../../environment.sh

for (( i=1; i <= $1; ++i ))
do
echo "Starting Job #$i"
java -jar "$SCRIPTPATH/jenkins-cli.jar" -noKeyAuth -s http://$JENKINS_IP:$JENKINS_PORT -auth admin:$JENKINS_TOKEN build WordPress-CI-Job &

done
exit 0