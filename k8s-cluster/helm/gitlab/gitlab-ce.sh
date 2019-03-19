#helm repo add gitlab https://charts.gitlab.io/
#helm repo update
helm install --name gitlab-test -f gitlab-ce.yaml gitlab/gitlab --namespace gitlab-test --wait --timeout 1000