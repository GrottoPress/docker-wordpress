ARG WORDPRESS_TAG=latest

FROM wordpress:${WORDPRESS_TAG}

RUN command -v apk >/dev/null && \
    apk add --no-cache \
        imagemagick \
        icu-dev \
        imap-dev; \
    command -v apt-get >/dev/null && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
        imagemagick \
        libc-client-dev \
        libicu-dev && \
    rm -r /var/lib/apt/lists/* && \
    apt-get -y autoremove

RUN command -v apk >/dev/null && \
    apk add --no-cache --virtual .build-deps \
        ${PHPIZE_DEPS} \
        imagemagick-dev \
        krb5-dev \
        openssl-dev; \
    command -v apt-get >/dev/null && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
        libkrb5-dev \
        libmagickwand-dev \
        libssl-dev; \
    pecl install imagick redis; \
    docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-install -j$(nproc) imap intl; \
    docker-php-ext-enable imagick imap intl redis; \
    command -v apk >/dev/null && \
    apk del .build-deps; \
    command -v apt-get >/dev/null && \
    rm -r /var/lib/apt/lists/* && \
    apt-get -y purge \
        libkrb5-dev \
        libmagickwand-dev \
        libssl-dev && \
    apt-get -y autoremove
