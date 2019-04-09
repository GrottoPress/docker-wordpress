ARG WORDPRESS_TAG=fpm-alpine

FROM wordpress:${WORDPRESS_TAG}

RUN apk add --no-cache \
        imagemagick \
        icu-dev \
        imap-dev

RUN apk add --no-cache --virtual .build-deps \
        ${PHPIZE_DEPS} \
        imagemagick-dev \
        krb5-dev \
        openssl-dev; \
    pecl install imagick redis; \
    docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-install -j$(nproc) imap intl; \
    docker-php-ext-enable imagick imap intl redis; \
    apk del .build-deps
