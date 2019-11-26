#!/bin/bash
# First, we create the Docker Swarm with 2 Debian containers to monitor.

# Initialize Docker Swarm, if needed.
docker swarm init

# Deploy the 2 container stack and name it 'prom-containers'.
docker stack deploy -c containers/container-stack.yml prom-containers

# List the container services that were just created.
docker service ls

# Next, we build and run the Prometheus container
docker build -t my-prometheus .
docker run -p 9090:9090 my-prometheus

# List all containers
docker ps