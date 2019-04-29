
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
. "$SCRIPTPATH"/../../environment.sh

helm delete pure-gitlab-${NS} --purge --timeout 1000
kubectl -n ${NS} delete pvc repo-data-pure-gitlab-${NS}-gitaly-0
#kubectl -n ${NS} delete pvc,secret --all
#kubectl -n ${NS} delete cm --all
#kubectl delete namespace ${NS}
