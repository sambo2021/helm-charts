#!/usr/bin/env bash
set -e -o pipefail
chart_version="5.50.0"
repo_name="argo-helm"
chart_name="argo-cd"
repo_url="https://argoproj.github.io/argo-helm"
release_name="argo-cd"
helm repo add --force-update ${repo_name} ${repo_url}
helm pull ${repo_name}/${chart_name} --version ${chart_version} --untar --untardir ../
##dont need to delete redis-ha chart since the default installation
##without it as mentioned in docs https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd
rm -rf ../${chart_name}/charts
rm ../${chart_name}/Chart.lock
yq m -x ../${chart_name}/values.yaml ./values-default.yaml > ./values.yaml
cat ./values.yaml > ../${chart_name}/values.yaml
rm ./values.yaml
cat ./Chart.yaml > ../${chart_name}/Chart.yaml