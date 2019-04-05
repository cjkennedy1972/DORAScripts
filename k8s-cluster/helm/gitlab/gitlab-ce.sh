helm repo add gitlab https://charts.gitlab.io/
helm repo update
#NS=gitlabtest
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
. "$SCRIPTPATH"/../../environment.sh

template=`cat "$SCRIPTPATH/gitlab-ce.yaml" | sed "s/{{NS}}/$NS/g" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{PV_ACCESS_MODE}}/$PV_ACCESS_MODE/g"`

kubectl create secret generic easy-gitlab-initial-root-password --from-literal=password=admin123 -n ${NS}
#helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
echo "$template" | helm install --name pure-gitlab-${NS} gitlab/gitlab --version 1.7.2 --namespace ${NS} \
--set global.hosts.domain=${GITLAB_DOMAIN} \
--set global.hosts.hostSuffix=${GITLAB_SUFFIX} \
-f -