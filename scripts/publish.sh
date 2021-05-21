#!/bin/bash

set -eufo pipefail

# check required commands and env variables are in place
command -v docker >/dev/null 2>&1 || { echo 'please install docker or use image that has it'; exit 1; }
if [[ -z "${DOCKER_USERNAME}" ]]; then
    echo 'DOCKER_USERNAME env variable is empty'; exit 1;
fi
if [[ -z "${DOCKER_PASSWORD}" ]]; then
    echo 'DOCKER_PASSWORD env variable is empty'; exit 1;
fi

docker_hub_prefix="xmartinezb"
image="taxibot"
image_hub=$docker_hub_prefix/$image


# push to DockerHub
echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
docker tag $image $image_hub
docker push $image_hub
docker rmi $image_hub
docker logout
