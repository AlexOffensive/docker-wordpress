#!/bin/bash

# Create directory for shared Volume web
mkdir -p web

# Create directory for shared Volume db
mkdir -p db

# Build the docker-compose config
docker-compose build

# Start the previously created stack
docker-compose up -d
