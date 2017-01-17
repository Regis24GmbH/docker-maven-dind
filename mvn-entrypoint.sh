#! /bin/bash -eu

set -o pipefail

# if we have "--link some-docker:docker" and not DOCKER_HOST, let's set DOCKER_HOST automatically
if [[ ! -v "DOCKER_HOST" ]] && [[ -v "DOCKER_PORT_2375_TCP" ]] ; then
  export DOCKER_HOST='tcp://docker:2375'
fi

exec "$@"
