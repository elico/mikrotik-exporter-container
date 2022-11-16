#!/usr/bin/env bash

cd build-dir && docker build -t local-build/mikrotik-exporter . && \
	docker run -it -v $(pwd):/build local-build/mikrotik-exporter
