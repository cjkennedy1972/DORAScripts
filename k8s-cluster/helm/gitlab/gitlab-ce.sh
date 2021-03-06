helm repo add gitlab https://charts.gitlab.io/
helm repo update
#NS=gitlabtest
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
. "$SCRIPTPATH"/../../environment.sh

#kubectl create ns ${NS}
kubectl create secret generic easy-gitlab-initial-root-password --from-literal=password=admin123 -n ${NS}
#helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
helm install --name pure-gitlab-${NS} gitlab/gitlab -f "${SCRIPTPATH}"/gitlab-ce.yaml --version 1.7.2 --namespace ${NS} --wait --timeout 1000 \
--set global.hosts.domain=${GITLAB_DOMAIN} \
--set global.hosts.hostSuffix=${GITLAB_SUFFIX} \
--set postgresql.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set postgresql.persistence.accessMode=${PV_ACCESS_MODE} \
--set redis.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set redis.persistence.accessMode=${PV_ACCESS_MODE} \
--set minio.persistence.storageClass=${STORAGE_CLASS_NAME} \
--set minio.persistence.accessMode=${PV_ACCESS_MODE} \
--set gitlab.gitaly.persistence.storageClass=${STORAGE_CLASS_NAME}
--set gitlab.gitaly.persistence.accessMode=${PV_ACCESS_MODE} \
#--set hosts.externalIP=${GITLAB_IP} \