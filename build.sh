#!/bin/bash

echo 'build Wordpress slack'
docker build -t wordpress - < Dockerfile
