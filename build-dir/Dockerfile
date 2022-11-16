FROM golang:alpine

RUN apk update && apk add upx

WORKDIR /build 
CMD ["/build/create.sh"]
