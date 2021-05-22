#!/bin/bash

set -eufo pipefail

release="off"
jfrog_server="txabman.jfrog.io"
repository_name="default-docker-local"

# check required commands and env variables are in place
command -v docker >/dev/null 2>&1 || { echo 'please install docker or use image that has it'; exit 1; }
if [[ -z "${JFROG_USERNAME}" ]]; then
    echo 'JFROG_USERNAME env variable is empty'; exit 1;
fi
if [[ -z "${JFROG_PASSWORD}" ]]; then
    echo 'JFROG_PASSWORD env variable is empty'; exit 1;
fi

while getopts "t:" opt; do
  case $opt in
    t) release="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

image="taxibot"
tag="latest"

if [[ $release == "on" ]]; then
    tag=$(git describe --abbrev=0 --tags)   
fi

image_hub=$jfrog_server/$repository_name/$image:$tag

echo "IMAGE HUB $image_hub"

# push to DockerHub
echo ${JFROG_PASSWORD} | docker login $jfrog_server -u ${JFROG_USERNAME} --password-stdin
docker tag $image $image_hub
docker push $image_hub
docker rmi $image_hub
