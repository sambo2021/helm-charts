#!/usr/bin/env bash
set -e -o pipefail
chart_version="0.49.0"
repo_name="oci://quay.io/strimzi-helm/strimzi-kafka-operator"
rm -rf ./strimzi-kafka-operator
helm pull ${repo_name} --version ${chart_version} --untar --untardir .
# to deploy the cahrt directly to k8s using helm
helm install strimzi-kafka-operator ./strimzi-kafka-operator --set rbac.create=false   --set createGlobalResources=false   --set watchNamespaces=["kafka"]

#if want to checkout how is the chart
rm -rf ./rendered
helm template strimzi-kafka-operator ./strimzi-kafka-operator --output-dir ./rendered --set rbac.create=false   --set createGlobalResources=false   --set watchNamespaces={kafka}
