#!/bin/bash
# Tear down everything we created in prom-deploy.sh
# Remove the prom-containers stack
docker stack rm prom-containers

# Get the docker container ID of the prometheus container
CONTAINER_ID=$(docker ps -aqf "label=server=prometheus")

# If it was found, then kill and remove the container
if [ "${CONTAINER_ID}" ]; then
  echo "Found Prometheus container, killing and removing now . . . ";
  docker container kill $(docker ps -aqf 'label=server=prometheus')
  docker container rm $(docker ps -aqf 'label=server=prometheus')
else
  # Else there was a problem and you might have to manual remove it if it still exists
  echo "WARNING: Could not find/remove Prometheus container";
fi