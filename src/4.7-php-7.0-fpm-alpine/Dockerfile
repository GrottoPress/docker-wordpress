FROM wordpress:php7.0-fpm-alpine

ENV WORDPRESS_VERSION 4.7.12
ENV WORDPRESS_SHA1 5a3fcf7f80327dfbea622a4b4f3c095a5bf099de

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress
