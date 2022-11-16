FROM alpine:latest

ARG TARGETOS
ARG TARGETARCH

RUN mkdir /config && mkdir /app

ADD config.yaml /config/config.yaml

ADD build-dir/${TARGETOS}/${TARGETARCH}/mikrotik-exporter /mikrotik-exporter
ADD start.sh /app/start.sh

EXPOSE 9436

CMD ["/bin/sh" , "/app/start.sh"]
