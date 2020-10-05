#!/bin/bash

echo 'build Wordpress slack'
docker build -t dk-wordpress - < Dockerfile
