helm repo add gitlab https://charts.gitlab.io/
helm repo update
#NS=gitlabtest
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
. "$SCRIPTPATH"/../../environment.sh

#kubectl create ns ${NS}
kubectl create secret generic easy-gitlab-initial-root-password --from-literal=password=admin123 -n ${NS}
#helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
helm install --name pure-gitlab-${NS} gitlab/gitlab -f "${SCRIPTPATH}"/gitlab-ce.yaml --namespace ${NS} --wait --timeout 1000 \
--set hosts.domain=${GITLAB_DOMAIN} \
--set hosts.suffix=${GITLAB_SUFFIX} \
--set postgresql.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set redis.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set minio.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set gitlab.gitaly.persistence.storageClass=k${STORAGE_CLASS_NAME}
#--set hosts.externalIP=${GITLAB_IP} \