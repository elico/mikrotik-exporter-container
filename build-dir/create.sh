#!/usr/bin/env sh

set -x

name="mikrotik-exporter"

CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o linux/amd64/"$name" main.go
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o linux/arm64/"$name" main.go
CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -o linux/arm/"$name" main.go

upx --best --lzma linux/amd64/"$name"
upx --best --lzma linux/arm64/"$name"
upx --best --lzma linux/arm/"$name"

set +x
