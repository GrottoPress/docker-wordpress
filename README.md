# WordPress Docker Image

WordPress, batteries included. Adds the following PHP extensions:

- imagick
- imap
- intl
- redis
- soap

## Usage

Example: `docker run -v app:/var/www/html grottopress/wordpress:5.6-php8.0-fpm-alpine`

WordPress requires a MySQL database to save data.

Additionally, you may need to run this in tandem with a frontend (eg. `nginx`), if you use any of the PHP-FPM variants.

Minimal example using [docker-compose](https://docs.docker.com/compose/):

```yaml
---
# docker-compose.yml
version: "3.7"
services:
  mariadb:
    image: mariadb:10.5
    restart: always
    volumes:
      - db:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: db-root-password
      MYSQL_DATABASE: wordpress-db-name
      MYSQL_USER: wordpress-db-user
      MYSQL_PASSWORD: wordpress-db-user-password
    networks:
      - back
  nginx:
    image: nginx:1.19-alpine
    depends_on:
      - wordpress
    ports:
      - "127.0.0.1:8080:80"
    restart: always
    volumes:
      - app:/var/www/html:ro
      - ./wordpress.conf:/etc/nginx/conf.d/wordpress.conf:ro
    networks:
      - front
  wordpress:
    image: grottopress/wordpress:5.6-php8.0-fpm-alpine
    depends_on:
      - mariadb
    environment:
      WORDPRESS_DB_HOST: mariadb:3306
      WORDPRESS_DB_NAME: wordpress-db-name
      WORDPRESS_DB_USER: wordpress-db-user
      WORDPRESS_DB_PASSWORD: wordpress-db-user-password
    restart: always
    volumes:
      - app:/var/www/html
    networks:
      - back
      - front
networks:
  back: {}
  front: {}
volumes:
  app: {}
  db: {}
```

You should have a `wordpress.conf` file in the same directory as the `docker-compose.yml`, with `fastcgi_pass wordpress:9000;` in its PHP location block(s).

Run `docker-compose up -d` to start the services.

## Need a WordPress development environment?

If using WordPress with docker for development, check out our [WordPress Development Environment](https://github.com/GrottoPress/wordpress-dev). It pulls together useful WordPress development tools, via docker-compose, to form a complete WordPress development solution.

[Check it out &raquo;](https://github.com/GrottoPress/wordpress-dev)

## Alternatives

If this does not satisfy your specific needs, check out the following images:

- [wordpress](https://hub.docker.com/_/wordpress)
- [bitnami/wordpress](https://hub.docker.com/r/bitnami/wordpress/)
