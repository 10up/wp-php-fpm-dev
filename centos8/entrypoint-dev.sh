#!/bin/bash

ENABLE_XDEBUG=$(echo ${ENABLE_XDEBUG:-false} | tr '[:upper:]' '[:lower:]')

if [ ${ENABLE_XDEBUG} == true ]; then
  sudo ln -fs /etc/php-extensions-available/15-xdebug.ini /etc/php.d/15-xdebug.ini
else
  sudo rm -f /etc/php.d/15-xdebug.ini
fi

# Ensure we have the host.docker.internal hostname available to linux as well
function fix_linux_internal_host() {
  DOCKER_INTERNAL_HOST="host.docker.internal"

  if ! grep $DOCKER_INTERNAL_HOST /etc/hosts > /dev/null ; then
    DOCKER_INTERNAL_IP=`/sbin/ip route|awk '/default/ { print $3 }'`
    echo -e "$DOCKER_INTERNAL_IP\t$DOCKER_INTERNAL_HOST" | sudo tee -a /etc/hosts > /dev/null
    echo 'Added $DOCKER_INTERNAL_HOST to hosts /etc/hosts'
  fi
}

if [ $(whoami) != "www-data" ]; then
    # highly likely we're on Linux and wp-local-docker, fix the internal host
    fix_linux_internal_host
fi

if [ ! -z "${EXEC_BASH}" ]; then
  exec /bin/bash -c ${COMMAND}
else
  exec /entrypoint.sh
fi
