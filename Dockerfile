FROM golang:1.16-alpine

EXPOSE 80

CMD ["/taxibot"]

ARG BUILD_TAG=unknown

LABEL BUILD_TAG=$BUILD_TAG

COPY bin/taxibot /taxibot

