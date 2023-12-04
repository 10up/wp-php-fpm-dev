# 10up/wp-php-fpm-dev

> This image extends the wp-php-fpm image to include additional tools focusing on developing WordPress using wp-local-docker-v2 and other development systems. These tools include git, vim, telnet, strace, wp-cli, nvm/node, composer. It is also configured to capture log output from PHP and log it to stderr.

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![MIT License](https://img.shields.io/github/license/10up/wp-php-fpm-dev.svg)](https://github.com/10up/wp-php-fpm-dev/blob/master/LICENSE)

## Supported tags

There are currently a number of images being built for the different operating systems. This image is built using 10up/wp-php-fpm as the base image with support for PHP 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1 and 8.2. Note that we do not build CentOS/Rocky Linux based images beyond 8.0 and they will be removed in the future. 

Also note that CentOS/RL based images are not being pushed to ghcr.io!

They are available under the tags:

* CentOS 7 based
  * 10up/wp-php-fpm-dev:5.6 (Deprecated, no longer refreshed)
  * 10up/wp-php-fpm-dev:7.0 (Deprecated, no longer refreshed)
  * 10up/wp-php-fpm-dev:7.1 (Deprecated, no longer refreshed)
* Rocky Linux 8 based
  * 10up/wp-php-fpm-dev:7.2 (Deprecated)
  * 10up/wp-php-fpm-dev:7.3 (Deprecated)
  * 10up/wp-php-fpm-dev:7.4 (Deprecated)
  * 10up/wp-php-fpm-dev:8.0 (Deprecated)
* Ubuntu 22.04 based (Docker Hub)
  * 10up/wp-php-fpm-dev:7.0-ubuntu
  * 10up/wp-php-fpm-dev:7.1-ubuntu
  * 10up/wp-php-fpm-dev:7.2-ubuntu
  * 10up/wp-php-fpm-dev:7.3-ubuntu
  * 10up/wp-php-fpm-dev:7.4-ubuntu
  * 10up/wp-php-fpm-dev:8.0-ubuntu
  * 10up/wp-php-fpm-dev:8.1-ubuntu
  * 10up/wp-php-fpm-dev:8.2-ubuntu
  * 10up/wp-php-fpm-dev:8.3-ubuntu
* Ubuntu 22.04 based (Github Packages)
  * ghcr.io/10up/wp-php-fpm-dev:7.0-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:7.1-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:7.2-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:7.3-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:7.4-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:8.0-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:8.1-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:8.2-ubuntu
  * ghcr.io/10up/wp-php-fpm-dev:8.3-ubuntu

## Usage

This image runs just php-fpm and expects that files are located at `/var/www/html`. They can be mounted or copied there using an init container. Running this image might look like this:

```
docker run -d --name phpfpm \
  -v /var/www/html:/var/www/html
  10up/wp-php-fpm-dev:8.2-ubuntu
```

This image is configured with MSMTP for handling email. It can only be configured to talk to an even smarter smart host meaning it cannot be configured with authentication of any sort. To configure MSMTP pass the following environment variables

* `MAILER_HOST=<your mailer host>`
* `MAILER_PORT=<your mailer hosts port>`

The entrypoint script will then configure MSMTP properly.

## Composer/nvm

This image contains composer versions 1 and 2. Composer 2 is used by default and to use composer 1, set the `COMPOSER_VERSION` env var to 1.

Node Version Manager is also installed and ready for use. You may find nvm is difficult to get loaded, be sure you are using a "login" prompt so that the nvm system has been loaded. For bash, this would mean "bash -l" should be called.

## Xdebug

Xdebug can be very slow on some systems. By default, xdebug will not be loaded. If you wish to have Xdebug loaded pass an environment variable of ENABLE_XDEBUG=true to enable it.

## Building

* `IMAGE_NAME` - The name of the image. For example, 10up sets this value to `10up/wp-php-fpm-dev`. You must set this to your own value.
* `DOCKERHUB_USERNAME` - The username for the Docker hub account you wish to push images to.
* `DOCKERHUB_TOKEN` - The token to use against your Docker hub account.
* `BASE_IMAGE` - The base image to build this image from. Typically this is `10up/wp-php-fpm`. If you are also customizing the wp-php-fpm image then setting this variable will ensure wp-php-fpm-dev is built from your customized base image. Note that we do not build CentOS/Rocky Linux based images beyond 8.0 and they will be removed in the future. 

## Support Level

**Active:** 10up is actively working on this, and we expect to continue work for the foreseeable future including keeping tested up to the most recent version of WordPress.  Bug reports, feature requests, questions, and pull requests are welcome.

## Like what you see?

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10up.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>
