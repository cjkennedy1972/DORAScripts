
#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
. "$SCRIPTPATH"/../../environment.sh

## Check if Mac or Linux
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

rp()
{
    if [ $machine = 'Mac' ]; then
        sed -i '' "$@"
    else
        sed -i "$@"
    fi
}

export -f rp

helm repo add gitlab https://charts.gitlab.io/
helm repo update

kubectl create -n ${NS} secret generic ${NS}-gitlab-initial-root-password  --from-literal=password=admin123

template=`cat "$SCRIPTPATH/values.yaml" | sed "s/{{NS}}/$NS/g" | sed "s/{{STORAGE_CLASS_NAME}}/$STORAGE_CLASS_NAME/g" | sed "s/{{PV_ACCESS_MODE}}/$PV_ACCESS_MODE/g"`

cp "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values.yaml" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/temp.xml"
rp "s/{{NS}}/${NS}/g" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/temp.xml"
rp "s/{{STORAGE_CLASS_NAME}}/${STORAGE_CLASS_NAME}/g" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/temp.xml"
rp "s/{{PV_ACCESS_MODE}}/${PV_ACCESS_MODE}/g" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/temp.xml"
mv "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values.yaml" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values2.yaml"
mv "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/temp.xml" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values.yaml"

echo "$template" | helm install --name pure-gitlab-new-${NS} "$SCRIPTPATH/gitlab-1-7-stable" --namespace ${NS} -f -

rm "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values.yaml"
mv "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values2.yaml" "$SCRIPTPATH/gitlab-1-7-stable/charts/minio/values.yaml"