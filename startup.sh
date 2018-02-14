#!/bin/bash

echo "try create example network"
docker network create example

if [ ! "$(docker ps -q -f name=traefik)" ]; then
  echo "run traefik"
  docker run \
    --publish 80:80 \
    --publish 8080:8080 \
    --publish 443:443 \
    --detach \
    --name=traefik \
    --network example \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /dev/null:/traefik.toml \
    traefik \
      --docker \
      --docker.exposedbydefault=false \
      --docker.watch=true \
      --docker.domain=localhost \
      --api
fi
