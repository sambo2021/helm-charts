#!/usr/bin/env bash
set -e -o pipefail
chart_version="1.28.0"
repo_name="istio"
chart_name="istiod"
repo_url="https://istio-release.storage.googleapis.com/charts/"
release_name="istiod"
helm repo add --force-update ${repo_name} ${repo_url}
rm -rf ./${chart_name}
helm pull ${repo_name}/${chart_name} --version ${chart_version} --untar --untardir .

## i made it as script instead of doing these commands
## in future maybe we need to override some values 
## namespace by default for this chart is istio-system
# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm install istiod istio/istiod -n istio-system --wait