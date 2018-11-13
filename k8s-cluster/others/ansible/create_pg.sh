NEXUS_PVC=$(kubectl -n pure get pvc | awk '/^pure-nexus/{print $3}')
JENKINS_PVC=$(kubectl -n pure get pvc | awk '/^pure-jenkins/{print $3}')
NEXUS_VOL="k8s-"$NEXUS_PVC
JENKINS_VOL="k8s-"$JENKINS_PVC

echo "The Nexus Pure Storage volume is " $NEXUS_VOL
echo "The Jenkins Pure Storage volume is " $JENKINS_VOL

ansible-playbook -i inventory.cfg create_pg.yaml --extra-vars "nexus_pso_vol=${NEXUS_VOL} jenkins_pso_vol=${JENKINS_VOL}"