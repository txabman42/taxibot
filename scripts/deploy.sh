#!/bin/bash

set -eufo pipefail

# Check required commands are in place
command -v helm >/dev/null 2>&1 || { echo 'Please install helm or use image that has it'; exit 1; }
command -v okteto >/dev/null 2>&1 || { curl https://get.okteto.com -sSfL | sh; }

jfrog_host=txabman.jfrog.io
helm_repo_name="default-helm-local"
chart_name="taxibot"

okteto login --token ${OKTETO_TOKEN}
okteto namespace txabman42
helm repo add $helm_repo_name https://$jfrog_host/artifactory/$helm_repo_name --username ${JFROG_USERNAME} --password ${JFROG_PASSWORD}
if ! helm install $chart_name $helm_repo_name/$chart_name ; then
    helm upgrade $chart_name $helm_repo_name/$chart_name
fi
