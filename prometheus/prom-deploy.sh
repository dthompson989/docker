#!/bin/bash
# First, we create the Docker Swarm with 2 Debian containers to monitor

# Check the Docker Swarm state, if ACTIVE then leave it.
case "$(docker info --format '{{.Swarm.LocalNodeState}}')" in
  active)
    # If the Swarm is active, but this node is not the manager, the leave and reinitialize the swarm
    if [ "$(docker info --format '{{.Swarm.ControlAvailable}}')" = "false" ]; then
      echo "Swarm ACTIVE (Not Manager): Leaving and Reinitializing Docker Swarm . . .";
      docker swarm leave --force
      docker swarm init
    fi
    ;;
  inactive)
    echo "Swarm INACTIVE: Initializing Docker Swarm . . .";
    docker swarm init
    ;;
  error)
    # If the Swarm is in an error state, then leave it and re initialize it to try to clean it up.
    echo "Swarm ERROR: Leaving and Reinitializing Docker Swarm . . .";
    docker swarm leave --force
    docker swarm init
    ;;
  *)
    echo "ERROR!!! Swarm is in an UNKNOWN state: $(docker info --format '{{.Swarm.LocalNodeState}}')"
    exit 1
    ;;
esac

# Deploy the container stack and name it 'prom-containers'
echo "------------------------------------------";
docker stack deploy prom-containers -c containers/node-express/docker-compose.yml

# Echo the stack that was just created
echo "------------------------------------------";
docker stack ls

# Scale the stack to 2 containers
echo "------------------------------------------";
CONTAINER_ID=$(docker service ls -q -f name=prom-containers)
if [ "${CONTAINER_ID}" ]; then
  docker service scale "${CONTAINER_ID}"=2
  # Echo the containers that were just scaled up
  echo "------------------------------------------";
  docker service ps "${CONTAINER_ID}"
else
  echo "ERROR: prom-containers not found";
fi

# Next, we build and run the Prometheus container
echo "------------------------------------------";
echo "Building and deploying Prometheus . . . ";
docker build -t my-prometheus --label server=prometheus .
docker run -p 9090:9090 my-prometheus