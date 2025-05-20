#!/usr/bin/env bash

REPOSITORY="hrcnthu/koch_arm_2204"
TAG="gpu"

IMG="${REPOSITORY}:${TAG}"

docker pull "${IMG}"
