#!/bin/bash
_kafka_version=$1
_kafka_tag=$2
_release_build=false

if [ -z "${_kafka_version}" ]; then
	source KAFKA_VERSION
	_kafka_version=$KAFKA_VERSION
	_kafka_tag=$KAFKA_VERSION
	_release_build=true
fi

echo "KAFKA_VERSION: ${_kafka_version}"
echo "DOCKER TAG: ${_kafka_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --build-arg kafka_version=${_kafka_version} --tag "stakater/kafka:${_kafka_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker tag "stakater/kafka:${_kafka_tag}" "stakater/kafka:latest"
fi