#helm repo add gitlab https://charts.gitlab.io/
#helm repo update
NS=gitlabtest
kubectl create ns ${NS}
kubectl create secret generic ${NS}-gitlab-initial-root-password --from-literal=password=admin123 -n ${NS}
#helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
--set postgresql.persistence.storageClass=kontena-storage-block \
--set redis.persistence.storageClass=kontena-storage-block \
--set minio.persistence.storageClass=kontena-storage-block \
--set gitlab.gitaly.persistence.storageClass=kontena-storage-block