#!/bin/bash

echo "try erase traefik "
for i in $(docker ps -a |grep traefik|awk '{print $1;}');do docker rm $i -f;done
for i in $(docker images |grep traefik|awk '{print $3;}');do docker rmi $i -f;done

echo "try remove example network "
docker network rm example
