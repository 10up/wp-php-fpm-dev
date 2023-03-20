ARG PHP_VERSION=8.2

# Set a BASE_IMAGE CI var to specify a different base image
ARG BASE_IMAGE=ghcr.io/10up/wp-php-fpm
FROM ${BASE_IMAGE}:${PHP_VERSION}-ubuntu

ARG PHP_VERSION=8.2

USER root
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y \
    php${PHP_VERSION}-xdebug \
    mariadb-client \
    netcat \
    wget \
    git \
    strace \
    telnet \
    rsync \
    vim \
    sudo \
    iproute2 \
    subversion \
    unzip && apt clean all && rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY scripts/composer-installer.sh /composer-installer.sh
COPY scripts/composer /usr/local/bin/composer
RUN \
  sh /composer-installer.sh && \
  chmod +x /usr/local/bin/composer 
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp
RUN echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/enable-all

# entrypoint needs to manage the PHP config but will be running as www-data
# Get things setup and then re-own the files necessary to allow this
#RUN  mkdir /etc/php-extensions-available; \
#  mv /etc/php/${PHP_VERSION}/mods-available/xdebug.ini /etc/php-extensions-available; \
#  chown www-data -R /etc/php*

COPY entrypoint-dev.sh /
COPY bash.sh /
RUN chmod +x /entrypoint-dev.sh && \
    chmod +x /bash.sh

RUN echo "opcache.validate_timestamps=1" >> /etc/php/${PHP_VERSION}/mods-available/docker-opcache.ini

RUN cp -a /etc/skel /home/www-data && chown 33:33 -R /home/www-data && usermod -d /home/www-data www-data
USER www-data
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
  source ~/.profile && \
  nvm install --lts && \
  composer global require 10up/wpsnapshots && \
  wp package install https://github.com/dustinrue/wpsnapshots/archive/refs/tags/3.0alpha1.zip && \
  echo "export PATH=$(composer global config bin-dir --absolute -q):$PATH" >> ~/.bashrc
WORKDIR /var/www/html

ENTRYPOINT []
CMD ["/entrypoint-dev.sh"]
