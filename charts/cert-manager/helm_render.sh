#!/usr/bin/env bash
set -e -o pipefail
chart_version="v1.19.1"
repo_name="jetstack"
chart_name="cert-manager"
repo_url="https://charts.jetstack.io"
release_name="cert-manager"
helm repo add --force-update ${repo_name} ${repo_url}
rm -rf ./${chart_name}
helm pull ${repo_name}/${chart_name} --version ${chart_version} --untar --untardir .


# helm install \
#   cert-manager jetstack/cert-manager \
#   --namespace cert-manager \
#   --create-namespace \
#   --version v1.19.1 \
#   --set crds.enabled=true