#!/bin/sh -e

image_id=$(docker build -f Dockerfile.windows . | tail -1 | cut -c20-)
container_id=$(docker run -dit "$image_id" /bin/bash -c 'tail -f /dev/null')

docker cp ../mason-cli/. "$container_id":home
docker exec "$container_id" /bin/bash -c './gen_win_exe.sh'
docker cp "$container_id":home/dist dist
