#!/bin/bash

# -t tagName (default: latest)

set -eufo pipefail

# Check required commands are in place
command -v docker >/dev/null 2>&1 || { echo 'Please install docker or use image that has it'; exit 1; }

name="taxibot"
tag="latest"

while getopts "t:" opt; do
  case $opt in
    t) tag="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo "Building $name as '$name:$tag'"
docker build "$PWD" -t "$name:$tag" --build-arg BUILD_TAG="$tag"
