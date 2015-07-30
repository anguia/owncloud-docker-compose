================================
Run Owncloud with docker-compose
================================

Copyright (c) 2015 Thomas Kock, License: MIT (see LICENSE.MIT.txt)

Uses the Dockerfile provided by https://github.com/l3iggs/docker-owncloud

- Can be run either with MySQL or with SQLite.
- Can be used behind the nginx-proxy from https://github.com/jwilder/nginx-proxy, when setting ``VIRTUAL_HOST`` in docker-compose.yml
- Can use https, when setup in nginx-proxy (just add the SSL-certificate)

Filesystem layout
-----------------

By using docker-volumes, this setup holds the database and OwnCloud files in the host filesystem.

::

  mysql
    +--volumes
       +--var
          +--lib
             +--mysql  -> mounted to /var/lib/mysql
  oc
    +--volumes
       +--config       -> mounted to /etc/webapps/owncloud/config
       +--data         -> mounted to /usr/share/webapps/owncloud/data
  docker-compose.yml
  rights.sh            -> set the access rights for ./oc/volumes/config & data


Configuration
-------------

Modify Docker-Compose

- currently configured and tested to be used with SQLite.

- With external MySQL:
  - uncomment "links mysql" lines
  - uncomment whole mysql block
  - keep ``START_MYSQL: false``

- local testing:
  - uncomment "ports 8000:80" lines

- behind nginx-proxy
  - configure ``VIRTUAL_HOST`` setting.


MySQL initialization
--------------------

It might be helpful to have MySQL initialize itself once before starting it via docker-compose. (There may be timing issues on first startup, while the
MySQL container is setting itself up.)

::

  docker run --name owncloud_mysql_1 \
     --env='MYSQL_DATABASE=owncloud' \
     --env='MYSQL_ROOT_PASSWORD=rootpass' \
     --env='MYSQL_USER=user' \
     --env='MYSQL_PASSWORD=userpass' \
     -v <path-to->/mysql/volumes/var/lib/mysql:/var/lib/mysql \
     -p 3307:3306 \
     mysql:latest


Startup
-------

Use ``rights.sh`` to setup the directory chmod/chgrp for the mounted volumes.

Initial startup with ``docker-compose up``, later with ``docker-compose start``.

Reconfigurations or modifications::

  docker-compose stop  # or CTRL-C
  docker-compose rm
  docker-compose up
