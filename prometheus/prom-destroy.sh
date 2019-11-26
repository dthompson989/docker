#!/bin/bash

# Tear down everything we created in prom-deploy.sh
docker stack rm prom-containers
docker container rm my-prometheus