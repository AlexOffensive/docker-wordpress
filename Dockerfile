### Dockerfile ###

FROM alpine:3.12
LABEL maintainer="alexandre.michel@reseau.eseo.fr"

# Install Apache2/PHP
RUN apk update && \
    apk add --no-cache apache2 php7 curl \
    php7-apache2 php7-mysqli php7-curl php7-mbstring php7-dom

# Install Wordpress
RUN sed -i 's#"/var/www/localhost/htdocs"#"/web/wordpress"#g' /etc/apache2/httpd.conf && \
    mkdir -p /web && \
    curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-5.5.1.tar.gz" && \
    tar -xzf wordpress.tar.gz -C /web && \
    rm wordpress.tar.gz && \

# Wordpress configuration 
    cp /web/wordpress/wp-config-sample.php /web/wordpress/wp-config.php && \
    mkdir -p /run/apache2 && chown -R apache:apache /run/apache2 && \
    chown -R apache:apache /var/www/localhost/htdocs && \
    chown -R apache.www-data /var/www/localhost/htdocs && \
    chown -R apache:apache /web && chown -R apache.www-data /web && \

# Wordpress Database config
    sed -i "s|define( 'DB_NAME', 'database_name_here' );|define( 'DB_NAME', 'wordpress_db'); |g" /web/wordpress/wp-config.php && \
    sed -i "s|define( 'DB_USER', 'username_here' );|define( 'DB_USER', 'wordpress'); |g" /web/wordpress/wp-config.php && \
    sed -i "s|define( 'DB_PASSWORD', 'password_here' );|define( 'DB_PASSWORD', 'network'); |g" /web/wordpress/wp-config.php && \
    sed -i "s|define( 'DB_HOST', 'localhost' );|define( 'DB_HOST', 'db'); |g" /web/wordpress/wp-config.php

# Expose HTTP port
EXPOSE 80

# Start Wordpress service
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# Mount web Volume for web files
VOLUME /web
