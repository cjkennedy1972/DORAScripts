#helm repo add gitlab https://charts.gitlab.io/
#helm repo update
NS=gitlabtest
kubectl create ns ${NS}
helm install --name ${NS} -f gitlab-ce.yaml gitlab/gitlab --namespace ${NS} --wait --timeout 1000
#kubectl create secret generic ${NS}-gitlab-initial-root-password --from-literal=password=admin123 -n ${NS}