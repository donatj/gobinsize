#!/bin/sh

set -e -x

export DOCKER_DEFAULT_PLATFORM=linux/amd64

mkdir -p output
rm -f output/*

build() {
	rm -rf gopath/bin gopath/pkg || echo "No bin or pkg directories to remove"
	docker run --rm -e GOPATH=/usr/src/myapp/gopath -v "$PWD":/usr/src/myapp -w /usr/src/myapp/gopath/src/"$2" golang:"$1" /bin/bash -c "go get && go build -o /usr/src/myapp/output/$3.$1"
}

for VER in 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 1.10 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.20 1.21 1.22 1.23
do
	echo "Building with golang:$VER"

	build $VER hello hello
	build $VER hello-nofmt hello-nofmt
	build $VER github.com/donatj/imgavg imgavg
	build $VER github.com/donatj/sqlread/cmd/sqlread sqlread
	build $VER github.com/donatj/hookah/cmd/hookah hookah

done
