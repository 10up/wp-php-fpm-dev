## Supported tags

* `7.2`, `7.3`, `7.4`

# CentOS 8 - wp-php-fpm-dev

This image extends the wp-php-fpm image to include additional tools focusing on developing WordPress using wp-local-docker-v2. These tools include git, vim, telnet, strace, wp-cli, nvm/node, composer. It is also configured to capture log output from PHP and log it to stderr.

## Usage

This image runs just php-fpm and expects that files are located at `/var/www/html`. They can be mounted or copied there using an init container. Running this image might look like this:

```
docker run -d --name phpfpm \
  -v /var/www/html:/var/www/html
  dustinrue/wp-php-fpm-dev
```

This image is configured with MSMTP for handling email. It can only be configured to talk to an even smarter smart host meaning it cannot be configured with authentication of any sort. To configure MSMTP pass the following environment variables

* `MAILER_HOST=<your mailer host>`
* `MAILER_PORT=<your mailer hosts port>`

The entrypoint script will then configure MSMTP properly.

## Xdebug

Xdebug can be very slow on some systems. By default, xdebug will not be loaded. If you wish to have Xdebug loaded pass an environment variable of ENABLE_XDEBUG=true to enable it.


## Building

This project takes advantage of custom build phase hooks as described at https://docs.docker.com/docker-hub/builds/advanced/. When setting up builds on docker hub create automated builds with rules to build for the master branch for each PHP version you want built. Currently this image is built with 7.2, 7.3 and 7.4.

