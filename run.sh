#!/bin/bash

echo "remove old containers"
docker rm -f db-mysql
docker rm -f srv-web

echo "run MySQL"
docker run --rm --name db \
           -e MYSQL_ROOT_PASSWORD=network \
           -e MYSQL_DATABSE=wordpress_db \
           -e MYSQL_USER=wordpress \
           -e MYSQL_PASSWORD=network \
           -v ./db:/var/lib/mysql \
           -d mysql:5.7.31

echo "run Web server (with wordpress)"
docker run --rm --name web \
           --link db:db \
           -e WORDPRESS_DB_HOST=db \
           -e WORDPRESS_DB_USER=wordpress \
           -e WORDPRESS_DB_PASSWORD=network \
           -e WORDPRESS_DB_NAME=wordpress_db \
           -v ./web:/var/www/localhost/htdocs \
           -d -p 8888:80 dk-wordpress
