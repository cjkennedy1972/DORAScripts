NEXUS_PVC=$(kubectl -n pure get pvc | awk '/^pure-nexus/{print $3}')
JENKINS_PVC=$(kubectl -n pure get pvc | awk '/^pure-jenkins/{print $3}')
PG_NAME="cicd-stack"
NEXUS_VOL="k8s-"$NEXUS_PVC
JENKINS_VOL="k8s-"$JENKINS_PVC

echo "The Nexus Pure Storage volume is " $NEXUS_VOL
echo "The Jenkins Pure Storage volume is " $JENKINS_VOL

SNAPSHOT_NUMBER=22
#NEXUS_SNAPSHOT=$PG_NAME.3.$NEXUS_VOL
#JENKINS_SNAPSHOT=$PG_NAME.3.$JENKINS_VOL

#echo "The Nexus snapshot name is " $NEXUS_SNAPSHOT
#echo "The Jenkins snapshot name is " $JENKINS_SNAPSHOT

#ansible-playbook -i inventory.cfg restore_snap.yaml --extra-vars "nexus_snap=${NEXUS_SNAPSHOT} jenkins_snap=${JENKINS_SNAPSHOT} snapshot_number=${SNAPSHOT_NUMBER}"

ansible-playbook -i inventory.cfg restore_snap.yaml --extra-vars "nexus_snap=${NEXUS_VOL} jenkins_snap=${JENKINS_VOL} snapshot_number=${SNAPSHOT_NUMBER}"