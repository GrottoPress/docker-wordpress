ARG WORDPRESS_TAG=latest

FROM wordpress:${WORDPRESS_TAG}

RUN apt-get update; \
    apt-get -y install --no-install-recommends \
        imagemagick \
        libc-client-dev \
        libicu-dev; \
    rm -r /var/lib/apt/lists/*; \
    apt-get -y autoremove

RUN apt-get update; \
    apt-get -y install --no-install-recommends \
        libkrb5-dev \
        libmagickwand-dev \
        libssl-dev; \
    pecl install imagick redis; \
    docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-install -j$(nproc) imap intl; \
    docker-php-ext-enable imagick imap intl redis; \
    rm -r /var/lib/apt/lists/*; \
    apt-get -y purge \
        libkrb5-dev \
        libmagickwand-dev \
        libssl-dev; \
    apt-get -y autoremove
