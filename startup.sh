#!/bin/bash

docker network create example
if [ ! "$(docker ps -q -f name=traefik)" ]; then
  echo "run traefik"
  # docker run \
  #   --publish 80:80 \
  #   --publish 8080:8080 \
  #   --publish 443:443 \
  #   --detach \
  #   --name=traefik \
  #   --network example \
  #   --volume /var/run/docker.sock:/var/run/docker.sock \
  #   --volume /dev/null:/traefik.toml \
  #   traefik \
  #     --docker \
  #     --docker.exposedbydefault=false \
  #     --docker.watch=true \
  #     --docker.domain=localhost \
  #     --api
fi

docker-compose down --remove-orphans
for i in $(docker ps -a |grep exampleops|awk '{print $1;}');do docker rm $i -f;done
for i in $(docker images |grep exampleops|awk '{print $3;}');do docker rmi $i -f;done
docker-compose pull
docker-compose up -d --build
docker-compose logs --follow
