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
        libxml2-dev \
        openssl-dev; \
    mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | \
        tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    mkdir -p /usr/src/php/ext/redis; \
    curl -fsSL https://github.com/phpredis/phpredis/archive/5.3.2.tar.gz | \
        tar xvz -C "/usr/src/php/ext/redis" --strip 1; \
    docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-install -j$(nproc) imagick imap intl redis soap; \
    docker-php-ext-enable imagick imap intl redis soap; \
    apk del .build-deps
