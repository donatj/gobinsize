#!/bin/sh

set -e -x

export DOCKER_DEFAULT_PLATFORM=linux/amd64

mkdir -p output
rm -f output/*

build() {
	docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp/"$2" golang:"$1" go build -o ../output/"$2"."$VER" .
}

for VER in 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 1.10 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.20
do
	echo "Building with golang:$VER"

	build $VER hello
	build $VER hello-nofmt
	build $VER imgavg

	# docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:"$VER" /bin/bash -c "go get -d github.com/donatj/sqlread/cmd/sqlread && go build -o output/sqlread.$VER github.com/donatj/sqlread/cmd/sqlread"
	# docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:"$VER" /bin/bash -c "go get -d github.com/donatj/hookah/cmd/hookah && go build -o output/hookah.$VER github.com/donatj/hookah/cmd/hookah"
done
