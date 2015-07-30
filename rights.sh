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
