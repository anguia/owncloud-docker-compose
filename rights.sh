#!/usr/bin/env bash
# see https://github.com/l3iggs/docker-owncloud/wiki/Store-your-data-outside-of-the-container
#
# ocfiles
chmod -R 770 ./owncloud/volumes/data/
chgrp -R 33 ./owncloud/volumes/data/
#
# config
chmod -R g+rw ./owncloud/volumes/config/
chgrp -R 33 ./owncloud/volumes/config/
#
# remove .gitignore file in postgres directory
if [ -e ./postgres/volumes/var/lib/postgresql/data/.gitignore ]
then
    echo -e "removing file ./postgres/volumes/var/lib/postgresql/data/.gitignore\n"
    rm -f ./postgres/volumes/var/lib/postgresql/data/.gitignore
else
    echo -e "not removing postgres .gitignore \n"
fi
#
# remove .gitignore file in mysql directory
if [ -e ./mysql/volumes/var/lib/mysql/.gitignore ]
then
    echo -e "removing file ./mysql/volumes/var/lib/mysql/.gitignore\n"
    rm -f ./mysql/volumes/var/lib/mysql/.gitignore
else
    echo -e "not removing mysql .gitignore\n"
fi
