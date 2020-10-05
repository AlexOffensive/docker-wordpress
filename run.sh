#!/bin/bash

echo "Remove old containers"
docker rm -f db-mysql
docker rm -f srv-web

echo "Create a network for container communication"
docker network create -d bridge wordpress_ntw | true 2> /dev/null

echo "Run MySQL"
docker run --rm --name db \
           --network wordpress_ntw \
           -e MYSQL_ROOT_PASSWORD=network \
           -e MYSQL_DATABSE=wordpress_db \
           -e MYSQL_USER=wordpress \
           -e MYSQL_PASSWORD=network \
           -v ./db:/var/lib/mysql \
           -d mysql:5.7.31

echo "Run Web server (with wordpress)"
docker run --rm --name web \
           --network wordpress_ntw \
           --link db:db \
           -e WORDPRESS_DB_HOST=db \
           -e WORDPRESS_DB_NAME=wordpress_db \
           -e WORDPRESS_DB_USER=wordpress \
           -e WORDPRESS_DB_PASSWORD=network \
           -v ./web:/web/wordpress \
           -d -p 8888:80 dk-wordpress
