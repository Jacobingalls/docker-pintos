#!/bin/bash

args="$@"

docker run \
    --name pintos \
    -it --rm \
    -v "$PWD:/pintos" \
    -p 1234:1234 \
    jacobingalls/docker-pintos \
        bash -c "
export TERM=xterm
set -e
(cd $(cat make_check_module) && make)
${args}
bash
"
