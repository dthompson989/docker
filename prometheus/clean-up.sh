#!/bin/bash
# This is a Docker clean up script. THIS SCRIPT WILL REMOVE EVERYTHING.
# Make sure you really want EVERYTHING gone before running this script. . . there is no going back.
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
# Remove any Docker Stacks
echo "Removing all Docker stacks"
docker stack rm rm $(docker stack ls)
printf "\n"

# Stop ALL running containers
echo "Stopping all running containers . . ."
docker container stop $(docker container ls -aq)
printf "\n"

# Remove all containers
echo "Removing all containers . . ."
docker container rm $(docker container ls -aq)
printf "\n"

# Remove all images
echo "Removing all images . . . "
docker image rm $(docker image ls -aq)
printf "\n"

# Remove all volumes, networks, and build cache
echo "Removing all volumes, networks, and build cache . . ."
docker volume prune -f
docker network prune -f
docker system prune -f

printf "\nAll Clean!\n\n"