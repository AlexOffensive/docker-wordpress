#!/bin/bash

# When run, this script will :
# set up the environment,
# build & run the docker-compose,
# show the slacks status

# Create directory for shared Volume web
mkdir -p web

# Create directory for shared Volume db
mkdir -p db

# Build the docker-compose config
echo "Build the docker-compose"
docker-compose build

# Start the previously created stack
echo "Start the docker containers"
docker-compose up -d

# Verify the state of slacks
docker ps
