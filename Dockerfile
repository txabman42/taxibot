FROM gitlab.otters.xyz:5005/product/systems/dockerfiles/docker-base-alpine/docker-base-alpine:latest

EXPOSE 80

CMD ["/taxibot"]

ARG BUILD_TAG=unknown
LABEL BUILD_TAG=$BUILD_TAG

COPY bin/taxibot /taxibot

