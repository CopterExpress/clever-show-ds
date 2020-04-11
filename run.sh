#!/bin/bash

name=sim-${1:-0}
echo $name

docker run \
    -it \
    --rm \
    --name $name \
    --hostname $name \
    --privileged=true \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    goldarte/clever-show-ds
