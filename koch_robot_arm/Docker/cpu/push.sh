#!/usr/bin/env bash

REPOSITORY="hrcnthu/koch_arm_2204"
TAG="cpu"

IMG="${REPOSITORY}:${TAG}"

docker image push "${IMG}"
