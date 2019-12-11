## Supported tags

* `5.6`, `7.0`, `7.1`, `7.2`, `7.3`, `7.4`

`5.6` through `7.1` is built using CentOS 7 and `7.2` through `7.4` is built using CentOS 8.

# CentOS - wp-php-fpm-dev

This image extends the wp-php-fpm image to include additional tools focusing on developing WordPress using wp-local-docker-v2. These tools include git, vim, telnet, strace, wp-cli, nvm/node, composer. It is also configured to capture log output from PHP and log it to stderr.

## Usage

This image runs just php-fpm and expects that files are located at `/var/www/html`. They can be mounted or copied there using an init container. Running this image might look like this:

```
docker run -d --name phpfpm \
  -v /var/www/html:/var/www/html
  10up/wp-php-fpm-dev
```

This image is configured with MSMTP for handling email. It can only be configured to talk to an even smarter smart host meaning it cannot be configured with authentication of any sort. To configure MSMTP pass the following environment variables

* `MAILER_HOST=<your mailer host>`
* `MAILER_PORT=<your mailer hosts port>`

The entrypoint script will then configure MSMTP properly.

## Xdebug

Xdebug can be very slow on some systems. By default, xdebug will not be loaded. If you wish to have Xdebug loaded pass an environment variable of ENABLE_XDEBUG=true to enable it.


## Building

This project takes advantage of custom build phase hooks as described at https://docs.docker.com/docker-hub/builds/advanced/. When setting up builds on docker hub create automated builds with rules to build for the master branch for each PHP version you want built. Currently this image is built with 5.6, 7.0, 7.1, 7.2, 7.3 and 7.4.

## Support Level

**Active:** 10up is actively working on this, and we expect to continue work for the foreseeable future including keeping tested up to the most recent version of WordPress.  Bug reports, feature requests, questions, and pull requests are welcome.

## Like what you see?

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10updotcom-wpengine.s3.amazonaws.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>
