# based on https://github.com/phoronix-test-suite/phoronix-test-suite/blob/master/deploy/docker/ubuntu-pts-docker-build.sh

FROM ubuntu:24.04

ADD --keep-git-dir=false https://github.com/phoronix-test-suite/phoronix-test-suite.git#v10.8.4 /phoronix-test-suite

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y unzip php-cli apt-utils mesa-utils php-xml git apt-file sudo build-essential autoconf bc bison flex libssl-dev cmake cmake-data libevent-dev libncurses5-dev zlib1g-dev libattr1-dev libjpeg-dev python3-pip python3-yaml libelf-dev cpio libapparmor-dev locales && \
	apt-get clean

RUN apt-file update
RUN locale-gen en_US.UTF-8

RUN /phoronix-test-suite/phoronix-test-suite make-openbenchmarking-cache lean

ENV PIP_BREAK_SYSTEM_PACKAGES=1
# pts/go-benchmark-1.1.4 uses a 2017 Go source tree (GOPATH-style, no go.mod).
# Go 1.16+ defaults to GO111MODULE=on which makes `go install golang.org/x/benchmarks/...`
# silently produce no binaries, so force GOPATH mode for the install step.
ENV GO111MODULE=off

RUN /phoronix-test-suite/phoronix-test-suite install pts/build-linux-kernel-1.18.0 pts/openssl-4.0.0 pts/mysqlslap-1.6.0 pts/valkey-1.1.1 pts/sqlite-2.3.0 pts/simdjson-2.2.0 pts/pyperformance-1.1.0 pts/nginx-3.1.0 pts/compress-zstd-1.6.0 pts/pgbench-1.17.0 pts/webp-1.4.0 pts/go-benchmark-1.1.4

COPY config/phoronix-test-suite.xml /etc/
