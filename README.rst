================================
Run Owncloud with docker-compose
================================

Copyright (c) 2016 Thomas Kock, License: MIT (see LICENSE.MIT.txt)

Uses the Dockerfile provided by https://github.com/l3iggs/docker-owncloud

- Can be run either with MySQL, PostgreSQL or with SQLite.
- Can be used behind the nginx-proxy from https://github.com/jwilder/nginx-proxy, when setting ``VIRTUAL_HOST`` in docker-compose.yml
- Can use https, when setup in nginx-proxy (just add the SSL-certificate)

Filesystem layout
-----------------

By using docker-volumes, this setup holds the database and OwnCloud files in the host filesystem.

::

  mysql
    +--volumes
       +--etc
          +--mysql
             +--conf.d     -> mounted to /etc/mysql/conf.d
       +--var
          +--lib
             +--mysql      -> mounted to /var/lib/mysql
  owncloud
    +--volumes
       +--config           -> mounted to /etc/webapps/owncloud/config
       +--data             -> mounted to /usr/share/webapps/owncloud/data
  postgresql
    +--volumes
       +--var
          +--lib
             +--postgresql
                +-- data   -> mounted to /var/lib/postgresql/data
  docker-compose-[sqlite|mysql|postgres].yml
  rights.sh                -> set the access rights for ./oc/volumes/config & data


Configuration
-------------

Depending on your database, select the proper docker-compose-[sqlite|mysql|postgres].yml file and copy it to ``docker-compose.yml``.

Modify Docker-Compose

- currently configured and tested to be used with SQLite.
- Postgres configuration kindly provided by ohugues (https://github.com/tkock/owncloud-docker-compose/issues/1)

- local testing:

  - uncomment "ports 8000:80" lines

- behind nginx-proxy

  - configure ``VIRTUAL_HOST`` setting.

- if you want to include the jwilder/nginx-proxy into the docker-compose.yml, please see https://github.com/tkock/owncloud-docker-compose/issues/1 for an example.
- for running jwilder/nginx-proxy with docker-compose, please see https://github.com/tkock/nginx-proxy-docker-compose


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


The current configuration provides a ``my-override.cnf`` file to reduce the memory footprint of mysql. Remove or modify according to your requirements.


Startup
-------

Use ``rights.sh`` to setup the directory chmod/chgrp for the mounted volumes.

Initial startup with ``docker-compose up``, later with ``docker-compose start``.

Reconfigurations or modifications::

  docker-compose stop  # or CTRL-C
  docker-compose rm
  docker-compose up

If starting/connecting to the MySQL database fails and you want to start over:

- do a ``docker-compose rm`` to remove the current container(s)
- do a ``rm -rf *`` in "./mysql/volumes/var/lib/mysql/" to remove the MySQL database files.

  - similar in postgres...

