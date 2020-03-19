ARG PHP_VERSION=7.1
FROM 10up/wp-php-fpm:${PHP_VERSION}

ARG PHP_VERSION=7.1

USER root
RUN export VERSION=$(echo $PHP_VERSION | sed -E 's/([0-9]).([0-9])/\1\2/g') && \
  yum install php-pecl-xdebug --enablerepo=remi-php${VERSION} \
  mariadb \
  nc \
  wget \
  git \
  strace \
  telnet \
  rsync \
  vim \
  sudo \
  iproute \
  unzip -y && yum clean all

WORKDIR /
COPY scripts/composer-installer.sh /composer-installer.sh
RUN sh /composer-installer.sh && mv /composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp
RUN echo "catch_workers_output = yes" >> /etc/php-fpm.d/www.conf
RUN echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/enable-all

# entrypoint needs to manage the PHP config but will be running as www-data
# Get things setup and then re-own the files necessary to allow this
RUN  mkdir /etc/php-extensions-available; \
  mv /etc/php.d/15-xdebug.ini /etc/php-extensions-available; \
  chown www-data -R /etc/php*

COPY entrypoint-dev.sh /
COPY bash.sh /
RUN chmod +x /entrypoint-dev.sh && \
    chmod +x /bash.sh

RUN echo "opcache.validate_timestamps=1" >> /etc/php.d/docker-opcache.ini

USER www-data
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash && \
  source ~/.bashrc && \
  nvm install --lts
WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint-dev.sh"]
