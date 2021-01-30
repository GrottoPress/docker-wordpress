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
    mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | \
        tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    mkdir -p /usr/src/php/ext/redis; \
    curl -fsSL https://github.com/phpredis/phpredis/archive/5.3.2.tar.gz | \
        tar xvz -C "/usr/src/php/ext/redis" --strip 1; \
    docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-install -j$(nproc) imagick imap intl redis; \
    docker-php-ext-enable imagick imap intl redis; \
    rm -r /var/lib/apt/lists/*; \
    apt-get -y purge \
        libkrb5-dev \
        libmagickwand-dev \
        libssl-dev; \
    apt-get -y autoremove
