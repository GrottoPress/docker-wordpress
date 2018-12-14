# WordPress Docker Images

Based on the official WordPress docker image. Adds several WordPress versions.

### Tags

- `4.7-php5.6-fpm-alpine`
- `4.7-php7.0-fpm-alpine`
- `4.7-php7.1-fpm-alpine`
- `4.7-php7.2-fpm-alpine`
- `4.8-php5.6-fpm-alpine`
- `4.8-php7.0-fpm-alpine`
- `4.8-php7.1-fpm-alpine`
- `4.8-php7.2-fpm-alpine`
- `4.9-php5.6-fpm-alpine`
- `4.9-php7.0-fpm-alpine`
- `4.9-php7.1-fpm-alpine`
- `4.9-php7.2-fpm-alpine`
- `5.0-php5.6-fpm-alpine`
- `5.0-php7.0-fpm-alpine`
- `5.0-php7.1-fpm-alpine`
- `5.0-php7.2-fpm-alpine`

## Usage

Command: `docker run -v app:/var/www/html grottopress/wordpress`

WordPress requires a MySQL database to save data.

Additionally, you may need to run this in tandem with a frontend (eg. `nginx`) that listens to this container on port `9000`.

**Minimal example using [docker-compose](https://docs.docker.com/compose/)**:

```yaml
# docker-compose.yml

version: "3"
services:
  mariadb:
    image: mariadb:latest
    restart: always
    volumes:
      - db:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: root-password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress-password
    networks:
      - back
  nginx:
    image: nginx:stable-alpine
    depends_on:
      - wordpress
    ports:
      - "8080:80"
    restart: always
    volumes:
      - app:/var/www/html:ro
      - ./wordpress.conf:/etc/nginx/conf.d/wordpress.conf:ro
    networks:
      - front
  wordpress:
    image: grottopress/wordpress:5.0-php7.2-fpm-alpine
    depends_on:
      - mariadb
    environment:
      WORDPRESS_DB_HOST: mariadb:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress-password
    restart: always
    volumes:
      - app:/var/www/html
    networks:
      - front
      - back
networks:
  front: {}
  back: {}
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

If this does not satisfy your specific need, check out the following images:

- [WordPress](https://hub.docker.com/_/wordpress/)
- [bitnami/wordpress](https://hub.docker.com/r/bitnami/wordpress/)
