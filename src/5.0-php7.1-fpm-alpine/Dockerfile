FROM wordpress:php7.1-fpm-alpine

ENV WORDPRESS_VERSION 5.0.3
ENV WORDPRESS_SHA1 f9a4b482288b5be7a71e9f3dc9b5b0c1f881102b

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress
